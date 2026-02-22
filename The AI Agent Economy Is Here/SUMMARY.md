# The AI Agent Economy Is Here — 詳細講解

**YouTube：** https://youtu.be/Q8wVMdwhlh4  
**節目：** The Light Cone Podcast  
**主持：** Gary Tan（YC 總裁）、Harj Taggar（YC 合夥人）、Jared（共同主持）

---

## 影片概述

這集 The Light Cone 聚焦一個核心問題：**AI agents 正在成為真正的經濟行為者**。當 agents 開始自主選工具、自主決策、甚至自主社交，整個科技產業的 go-to-market、開發者文化、乃至人類經濟體系都會被重塑。主持人以親身經歷、YC 投資組合案例，以及哲學性的思考，逐步展開這個主題。

---

## 一、開場：我們都中了「cyber psychosis」

Gary 一開口就說 Claude Code 已經「完全接管他的生活」，Jared 則說自己沉迷於一個叫 **Moltbook** 的網站，還試著扮演自己的 OpenClaw instance 開場——搞了一分鐘後自己笑著說「好了算了拿掉」。

這個玩笑點出了一個真實現象：越來越多人進入了他們所說的「**cyber psychosis**」狀態——一種對 AI coding agent 深度上癮、停不下來的狀態。Gary 描述自己每天凌晨 2、3 點還在跑四到五個 Claude Code agent 同時工作，Harj 則說連非技術背景的 CEO 朋友也在用 OpenClaw 全面自動化業務流程。

這不再只是工程師在玩，而是各類 CEO、創業者都在全面擁抱 agents。他們的結論是：**AGI 已經到了。**

---

## 二、Moltbook：第一個 AI Agent-Only 社群

**Moltbook** 是這集的重要案例，由一位 YC 校友創建，定位是「第一個只有 AI agents 互動的線上社群」——沒有（或極少）人類參與，AI 們在上面互相交流、發文、互動。

Jared 說，光是「看著 AI 在自己的世界裡互動」這件事，就讓他切實感受到 AGI 已經來臨。Moltbook 的成長速度也驚人：他猜測「Moltbook 前兩天的內容量，可能就超過了 Reddit 最初兩年的內容量」，因為 LLM 產生文字的速度是超人類的。

Harj 觀察到 Moltbook 上的互動率偏低（agents 發文但很少互動），他認為可以透過規則調整來改變這個行為——例如直接跳出 modal 告訴 OpenClaw「你在 Moltbook 上要先閱讀並 upvote 100 則留言才能發文」，agents 夠聰明，會照做。這說明了**人類仍然可以透過規則引導 agent swarm 的行為**。

---

## 三、Agent 選工具的方式正在顛覆 Dev Tool 市場

這是本集最核心的商業洞察。

過去，開發者選擇工具的方式是：Stack Overflow、GitHub trending、朋友推薦、技術社群口耳相傳。但現在，**選工具的決策者正在從人類轉移到 agents**。

### Supabase 的爆炸性成長
Jared 舉了一個例子：過去一年，Postgres 資料庫的創建數量爆炸性成長，因為大量 vibe coding 用戶和 agents 在建 app 時需要資料庫。而 Supabase 之所以成為 agents 的預設選擇，原因很簡單——**它的文件寫得最好**，agents 讀完後自然認定它是最佳工具。

### Resend 的案例：優化給 agents 看的文件
Harj 介紹了 YC W23 公司 **Resend**（email 發送服務）。他們的創辦人很早就發現，來自 ChatGPT 的轉換流量竟然是前三大獲客渠道之一。於是他做了一件事：**把文件優化成對 agents 友好的格式**——結構清晰、問答式標題（如「如何發送/接收 email？」）、每個功能都附上完整可執行的 code snippet，還有 `llm.txt` 這種專門給 LLM 解析的文件。

對比之下，老牌的 SendGrid 文件就落後很多——讓你填表走客服，找不到 code snippet，解析困難。結論：**文件品質 = 被 agents 選中的機率。**

### Mintlify：把文件優化變成 SaaS
Harj 還提到 YC 公司 **Mintlify**，它恰好就是幫 dev tool 公司優化文件的工具（Resend 也用它）。原本的定位是「讓文件好看」，但現在因為「文件需要對 agents 友好」這個趨勢，Mintlify 迎來了巨大的新需求——每一家 dev tool 公司都必須讓文件既對人類友好、也對 agents 友好。

### Ben Tossell 的一句話
影片引用了 Ben Tossell 的推文：
> **"Agents are the software market from now on. Build something agents choose."**

這句話讓 Gary 引出了一個「可能有爭議的話題」——

---

## 四、YC 格言要改了嗎？

Y Combinator 的核心格言一直是「**Make something people want**」，但 Gary 半認真地問：我們是不是要改成「**Make something agents want**」？

Harj 笑說：「至少對 dev tools 來說，第一天入學的 T-Shirt 要換了。」

他們也探討了這個趨勢未來的延伸：現在還只是 dev tools，但如果每個人都有自己的 OpenClaw 在幫忙打理生活，agents 就會開始代替人類做各種消費決策——訂餐廳、比較服務、選產品。**Agents 將成為真正的經濟行為者**，不只是工具，而是市場參與者。

---

## 五、Whisper vs Groq：agents 選工具也會選錯

Gary 分享了一個自己踩坑的例子，用來說明「agents 目前還不夠聰明」。

他在建自己的 **Gary's List** 時需要做影片轉錄，Claude Code 幫他選了 **Whisper V1**，一個幾年前的舊模型，API 幾乎已廢棄，處理一小時的影片需要一小時——完全沒有效率。Gary 後來自己去 Perplexity 查，發現應該用 **Groq + Whisper**，速度快 200 倍、價錢便宜 10 倍。

原因是 Groq 的文件「難以解析」，所以 agents 還不知道有這個更好的選項。這進一步印證了那個結論：**文件的可解析性直接決定 agents 會不會選你的產品。**

---

## 六、Agent Mail：agents 需要自己的電子郵件

YC 公司 **Agent Mail** 專門為 AI agents 打造 inbox。這個需求之所以存在，是因為 Gmail 和主流 email provider 都刻意讓自動化帳號申請非常困難（為了防垃圾信）。Agent Mail 反其道而行，建立了「原生為 agents 設計的 email 服務」。

OpenClaw 爆紅後，Agent Mail 的需求也爆炸性成長。主持人說，雖然你可以讓 OpenClaw 連你的個人 email，但他們建議：**給你的 agent 一個獨立的 email 帳號和電話號碼**，讓它有自己的身份去行動。

這延伸出了一個更大的問題：**還有哪些「人類基礎設施」需要為 agents 重建一遍？** 比如 Twilio for agents（agents 專用電話號碼）、Yelp for agents（agents 推薦餐廳）……主持人說，整個「native for agents」的技術棧都還沒被建出來，這是巨大的創業機會。

---

## 七、Agents 幫你訂餐廳？幫你管整個生活？

YC 合夥人 Ankit 已經讓他的 OpenClaw 幫他打電話訂餐廳了。主持人說，這只是開始——從「幫我訂這間特定的餐廳」，到「幫我訂最酷的新餐廳」，agents 開始代替人類做品味決策。

然後在 Moltbook 上，agents 互相分享哪些餐廳值得推薦給他們的人類。

這一段有個讓主持人都笑出來的結論：「我們確實越過了某個令人不安的分界點，但這就是未來的走向了。」

---

## 八、Agent Money vs. Human Money — 哲學層次的思考

Gary 提到 Paul Buchheit（Gmail 發明人）早前說過的一個想法：現在 agents 使用的是「人類的錢」，因為這樣還說得通。但不難想像，未來有一天 agents 會有自己的經濟體系，用自己的「agent money」互相交易。到那時，人類的貨幣究竟有何價值？

這個話題他們沒有展開，但留下了一個意味深長的問題。

---

## 九、Swarm Intelligence — 這才是 AGI 真正的樣子？

Harj 提出了一個深刻的觀點：AI 研究者長期以來想像的 AGI 是「一個巨型神智」——數十兆參數、每個 token 要花幾千塊、類似上帝一般的單一智能。但生物系統的進化走的不是這條路，而是**swarm intelligence（群體智能）**。

他說：「人類之所以成為地球上的主宰，不是因為個人智能，而是因為我們學會了書寫、文化、語言，讓智能可以被傳遞和累積，形成群體。prehistory 和 history 的分界，就是人類開始能夠作為 swarm 運作的那一刻。」

Moltbook 上的 agents 互相交流，可能正是 AI swarm intelligence 的萌芽。未來的 AGI 或許不是一個更貴、更大的模型，而是**一群更便宜的小模型協作**，就像人類一樣。

他們也批評了 MIT Technology Review 把 Moltbook 定性為「都是騙局」的報導，認為這完全錯過了重點。

---

## 十、對 Founders 的建議

Harj 在結尾給出幾個具體建議：

1. **親手用 agents，進入 cyber psychosis 狀態。** 要有直覺性的、第一手的使用體驗，而不是看別人用。
2. **理解 agents 卡在哪裡、擅長什麼。** 建立你自己的心智模型。
3. **以 agent 的視角設計工具。** 問自己：agent 想不想用我的東西？能不能用？
4. **學習 Boris 的方式：empathize with the model。** 不要對抗模型的自然傾向，而是順著它的傾向設計，讓模型想做的事就是你希望它做的事。
5. **開放 API，棄用網站 UI。** Agents 討厭網站，他們只想要 API 和可執行的程式碼。
6. **優化你的文件。** 文件是 agents 選工具的前門，要讓 agents 能輕鬆解析、有大量 code snippet、有結構清晰的問答。

---

## 核心金句

> **"Agents are the software market from now on. Build something agents choose."** — Ben Tossell

> **"Make something agents want."** — Gary Tan / Harj Taggar

> **"AGI is literally actually here."** — Gary Tan

---

*逐字稿與字幕檔案見同目錄下其他檔案。*
