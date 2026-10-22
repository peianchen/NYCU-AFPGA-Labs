# 公開版本說明

[總覽](../README.md) · [驗證與重現](VALIDATION.md)

2026 年 10 月 22 日整理公開版，以現有 Lab 01–08 的 Markdown、HDL、Quartus/Qsys 設定與選定結果圖片建立新的 Git 歷史。含整份 Word/PDF 作業報告的舊提交不接入公開分支；原始文件與完整歷史另存本機備份。

## 保留內容

- 八份 Lab 說明及各子專案 README。
- 原始 HDL、必要 IP/Qsys 描述、腳位表與記憶體初始化檔。
- 原始報告內嵌的板端照片、RTL 圖與 Linux console。這些是歷史實驗紀錄。
- 原始檔案中的 Altera/Terasic 等第三方著作權與授權聲明。

## 公開前整理

- 排除原始 Word/PDF、安裝程式、編譯資料庫、私人備份與學號檔名。
- 將舊的個人模擬輸出路徑改成相對路徑，移除本機 programmer chain 設定。
- 檢視結果圖；移除 Linux console JPEG 的 EXIF／附加 metadata，保留原始壓縮影像資料。
- 公開版不新增 FPGA 上板、量測、timing closure 或完整 Lab 重建的宣稱。

## 維護方式

已有舊 clone 的使用者應重新 clone 公開版本，避免把舊分支 merge 或 push 回來。新增圖片前需檢查畫面上的個資與 metadata；單純將檔案加入 `.gitignore` 不能清除既有 Git 歷史。

Repository 可公開閱讀不等於所有內容均可任意再授權。第三方 IP 與工具檔案沿用各自聲明；重用時請核對來源與適用條件。
