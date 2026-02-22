#!/usr/bin/env bash
# ============================================================
#  process_video.sh — 影片字幕自動化流程
#  用法：
#    ./process_video.sh \
#      --url    "https://youtu.be/xxxx" \
#      --lang   "en" \
#      --email  "someone@gmail.com,another@gmail.com"
# ============================================================

set -e

# ── 預設值 ──────────────────────────────────────────────────
LANG_CODE="en"
EMAILS=""
VIDEO_URL=""
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── 解析參數 ─────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    --url)   VIDEO_URL="$2"; shift 2 ;;
    --lang)  LANG_CODE="$2"; shift 2 ;;
    --email) EMAILS="$2"; shift 2 ;;
    *) echo "未知參數：$1"; exit 1 ;;
  esac
done

# ── 必要參數檢查 ──────────────────────────────────────────────
if [[ -z "$VIDEO_URL" ]]; then
  echo "錯誤：請提供 --url"
  echo "用法：$0 --url <YouTube URL> [--lang en] [--email a@b.com,c@d.com]"
  exit 1
fi

# ── 1. 取得影片標題 ──────────────────────────────────────────
echo "📥 取得影片資訊..."
VIDEO_TITLE=$(yt-dlp --print title "$VIDEO_URL" 2>/dev/null)
if [[ -z "$VIDEO_TITLE" ]]; then
  echo "錯誤：無法取得影片標題，請確認 URL 正確"
  exit 1
fi
echo "   標題：$VIDEO_TITLE"

# 建立資料夾（影片名稱）
VIDEO_DIR="$REPO_DIR/$VIDEO_TITLE"
mkdir -p "$VIDEO_DIR"

RAW_VTT="$VIDEO_DIR/$VIDEO_TITLE.$LANG_CODE.vtt"
CLEAN_VTT="$VIDEO_DIR/$VIDEO_TITLE.$LANG_CODE.clean.vtt"
CLEAN_SRT="$VIDEO_DIR/$VIDEO_TITLE.$LANG_CODE.srt"
CLEAN_TXT="$VIDEO_DIR/$VIDEO_TITLE.$LANG_CODE.txt"
SUMMARY_MD="$VIDEO_DIR/SUMMARY.md"

# ── 2. 下載字幕 ───────────────────────────────────────────────
echo "📥 下載 $LANG_CODE 字幕..."
yt-dlp \
  --write-auto-sub \
  --sub-lang "$LANG_CODE" \
  --skip-download \
  --sub-format vtt \
  --output "$VIDEO_DIR/$VIDEO_TITLE.%(ext)s" \
  "$VIDEO_URL" 2>/dev/null

# yt-dlp 產生的檔名格式
DOWNLOADED=$(ls "$VIDEO_DIR"/*.${LANG_CODE}.vtt 2>/dev/null | head -1)
if [[ -z "$DOWNLOADED" ]]; then
  echo "錯誤：字幕下載失敗（語言 $LANG_CODE 可能不存在）"
  exit 1
fi
mv "$DOWNLOADED" "$RAW_VTT" 2>/dev/null || true
echo "   原始字幕：$RAW_VTT"

# ── 3. 清理字幕 ───────────────────────────────────────────────
echo "🧹 清理字幕..."
python3 "$SCRIPTS_DIR/clean_subtitles.py" \
  --input  "$RAW_VTT" \
  --output-vtt "$CLEAN_VTT" \
  --output-srt "$CLEAN_SRT" \
  --output-txt "$CLEAN_TXT"
echo "   完成：VTT / SRT / TXT"

# ── 4. 產生摘要（交給 AI agent 處理，這裡輸出佔位符）──────────
echo "📝 摘要請手動或透過 AI agent 根據 $CLEAN_TXT 生成後存為 $SUMMARY_MD"

# ── 5. 推到 GitHub ────────────────────────────────────────────
echo "🚀 推上 GitHub..."
cd "$REPO_DIR"
git add "$VIDEO_DIR/"
git add README.md 2>/dev/null || true
git commit -m "Add subtitles: $VIDEO_TITLE [$LANG_CODE]" 2>/dev/null || echo "   （無新變更）"
git push 2>/dev/null
REPO_URL=$(git remote get-url origin | sed 's/\.git$//')
FOLDER_URL="$REPO_URL/tree/main/$(python3 -c "import urllib.parse; print(urllib.parse.quote('$VIDEO_TITLE'))")"
echo "   $FOLDER_URL"

# ── 6. 寄 Email ───────────────────────────────────────────────
if [[ -n "$EMAILS" ]]; then
  echo "📧 寄送 email..."
  source ~/.zshrc 2>/dev/null || true

  IFS=',' read -ra EMAIL_LIST <<< "$EMAILS"
  for EMAIL in "${EMAIL_LIST[@]}"; do
    EMAIL=$(echo "$EMAIL" | xargs)  # trim whitespace
    gog gmail send \
      --to "$EMAIL" \
      --subject "字幕整理完成：$VIDEO_TITLE" \
      --body-file - << EMAILEOF
Hi，

以下是影片「$VIDEO_TITLE」的整理結果。

YouTube 連結：$VIDEO_URL
語言：$LANG_CODE

━━ 字幕檔案 ━━

GitHub：$FOLDER_URL

包含：
- 原始 VTT（yt-dlp 下載）
- 清理後 WebVTT（完整句子 cue，無 rolling-window 重複）
- SRT 格式
- 純文字逐字稿（無時間戳）

EMAILEOF
    echo "   ✅ 已寄給 $EMAIL"
  done
fi

echo ""
echo "✅ 全部完成！"
echo "   影片：$VIDEO_TITLE"
echo "   語言：$LANG_CODE"
echo "   資料夾：$VIDEO_DIR"
[[ -n "$EMAILS" ]] && echo "   Email：$EMAILS"
