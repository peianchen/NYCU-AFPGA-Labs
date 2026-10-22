# Repository 使用與維護

[總覽](../README.md) · [公開版本說明](PUBLICATION.md)

此 repository 已建立，使用下列指令取得公開版：

```powershell
git clone https://github.com/peianchen/NYCU-AFPGA-Labs.git
cd NYCU-AFPGA-Labs
```

從 `docs/LABS.md` 選擇實驗，再閱讀 Lab 與子專案 README。重建條件與驗證限制見 [VALIDATION.md](VALIDATION.md)。

更新文件時只 stage 檢視過的檔案，檢查 `git diff --cached` 與 `git diff --check`。不要加入整份原始報告、個資、安裝程式、編譯資料庫或備份 bundle。

已持有公開整理前的 clone 時，請重新 clone；不要把舊歷史合併回公開版本。
