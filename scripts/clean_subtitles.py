#!/usr/bin/env python3
"""
clean_subtitles.py — 清理 YouTube auto-generated VTT 字幕
去除 rolling-window 重複、inline timing tags，輸出 clean VTT / SRT / TXT
"""

import re, html, argparse

def parse_ms(t):
    h, m, s = t.strip().replace(',', '.').split(':')
    return int(h) * 3600000 + int(m) * 60000 + int(float(s) * 1000)

def ms2vtt(ms):
    h = ms // 3600000; ms %= 3600000
    m = ms // 60000;   ms %= 60000
    s = ms // 1000;    ms %= 1000
    return f"{h:02d}:{m:02d}:{s:02d}.{ms:03d}"

def ms2srt(ms):
    h = ms // 3600000; ms %= 3600000
    m = ms // 60000;   ms %= 60000
    s = ms // 1000;    ms %= 1000
    return f"{h:02d}:{m:02d}:{s:02d},{ms:03d}"

def clean_text(raw):
    t = re.sub(r'<\d{2}:\d{2}:\d{2}\.\d+>', '', raw)
    t = re.sub(r'</?c>', '', t)
    t = re.sub(r'<[^>]+>', '', t)
    t = html.unescape(t)
    return re.sub(r'\s+', ' ', t).strip()

def find_overlap(prev, curr):
    for n in range(min(len(prev), len(curr)), 0, -1):
        if prev[-n:] == curr[:n]:
            return n
    return 0

SENT_SPLIT = re.compile(r'(?<=[.!?])\s+(?=[A-Z\[>])')
MAX_WORDS  = 40

def process(input_path, output_vtt, output_srt, output_txt):
    with open(input_path, encoding='utf-8') as f:
        content = f.read()

    # 1. Parse raw cues
    raw = []
    for block in re.split(r'\n\n+', content.strip()):
        lines = block.strip().split('\n')
        ti = next((i for i, l in enumerate(lines) if '-->' in l), None)
        if ti is None:
            continue
        timing = re.sub(r' align:\S+| position:\S+', '', lines[ti])
        txt = clean_text(' '.join(lines[ti+1:]))
        if not txt:
            continue
        s, e = timing.split(' --> ')
        raw.append({'s': parse_ms(s), 'e': parse_ms(e), 't': txt})

    # 2. Drop 10ms transition cues
    cues = [c for c in raw if c['e'] - c['s'] > 50]

    # 3. Extract non-overlapping fragments
    frags, prev = [], ""
    for c in cues:
        ov  = find_overlap(prev, c['t'])
        new = c['t'][ov:].strip()
        if new:
            frags.append({'s': c['s'], 'e': c['e'], 't': new})
        prev = c['t']

    # 4. Split fragments at intra-sentence boundaries
    split_frags = []
    for f in frags:
        parts = SENT_SPLIT.split(f['t'])
        if len(parts) == 1:
            split_frags.append(f)
        else:
            total  = max(len(f['t']), 1)
            cursor = f['s']
            for i, p in enumerate(parts):
                dur = int((f['e'] - f['s']) * len(p) / total)
                e   = cursor + dur if i < len(parts) - 1 else f['e']
                split_frags.append({'s': cursor, 'e': e, 't': p.strip()})
                cursor = e

    # 5. Merge into sentence-level cues
    merged = []
    acc_t, acc_s, acc_e = "", None, None

    def flush():
        nonlocal acc_t, acc_s, acc_e
        if acc_t.strip():
            merged.append({'s': acc_s, 'e': acc_e, 't': acc_t.strip()})
        acc_t, acc_s, acc_e = "", None, None

    for i, f in enumerate(split_frags):
        txt        = f['t']
        is_speaker = txt.lstrip().startswith('>>')

        if is_speaker and acc_t:
            flush()

        if not acc_t:
            acc_t, acc_s, acc_e = txt, f['s'], f['e']
        else:
            acc_t = acc_t.rstrip() + ' ' + txt
            acc_e = f['e']

        ends      = bool(re.search(r'[.!?]$', acc_t.rstrip()))
        words     = len(acc_t.split())
        next_txt  = split_frags[i+1]['t'].lstrip() if i + 1 < len(split_frags) else None
        next_new  = next_txt is not None and bool(re.match(r'[A-Z\[]|>>', next_txt))

        if ends and (next_new or next_txt is None):
            flush()
        elif words >= MAX_WORDS and ends:
            flush()

    if acc_t:
        flush()

    # 6. Write outputs
    if output_vtt:
        with open(output_vtt, 'w', encoding='utf-8') as f:
            f.write("WEBVTT\n\n")
            for c in merged:
                f.write(f"{ms2vtt(c['s'])} --> {ms2vtt(c['e'])}\n{c['t']}\n\n")

    if output_srt:
        with open(output_srt, 'w', encoding='utf-8') as f:
            for i, c in enumerate(merged, 1):
                f.write(f"{i}\n{ms2srt(c['s'])} --> {ms2srt(c['e'])}\n{c['t']}\n\n")

    if output_txt:
        with open(output_txt, 'w', encoding='utf-8') as f:
            f.write('\n'.join(c['t'] for c in merged) + '\n')

    print(f"✅ {len(merged)} cues → VTT / SRT / TXT")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--input',       required=True)
    parser.add_argument('--output-vtt',  default=None)
    parser.add_argument('--output-srt',  default=None)
    parser.add_argument('--output-txt',  default=None)
    args = parser.parse_args()
    process(args.input, args.output_vtt, args.output_srt, args.output_txt)
