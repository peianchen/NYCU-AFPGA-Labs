# 驗證狀態與重現指南

[總覽](../README.md) · [Lab 索引](LABS.md)

## 證據怎麼讀

| 類別 | 已保存內容 | 能支持的結論 | 不能支持的結論 |
| --- | --- | --- | --- |
| 原始實驗圖 | 板上 LED／七段顯示、console、RTL Viewer | 當時記錄的輸入輸出與結構 | 所有輸入組合、所有硬體版本均正確 |
| 工程檔 | HDL、QPF/QSF、Qsys、MIF、VWF | 可檢查設計與工程設定 | 每個工程可直接由目前工具重建 |
| 代表重建 | Lab 01 Part 01 曾以 Quartus 25.1 full compilation 完成，0 errors / 248 warnings | 該代表工程的建置結果 | 全部實驗已建置、時序已收斂、已重新上板 |
| 公開整理 | 文件連結、檔名、程式與圖片清單檢查 | 公開文件與來源可追蹤 | 電路或實驗的物理性能 |

## 一般重現流程

1. 將目標工程複製到純 ASCII、短路徑工作目錄，避免舊版工具對中文路徑的限制。
2. 先讀該 Lab 與子專案 README；記錄工具版本、板型、device、top-level 與 IP 版本。
3. 檢查腳位、時脈與 reset；不要直接套用不同開發板的 pin assignments。
4. 執行 Analysis & Synthesis，檢查警告；再依需求執行 simulation 與 full compilation。
5. Timing Analyzer 需有適當 SDC／clock constraints；沒有 constraints 不能視為 timing closure。
6. 上板時依 Lab 的測試表設定輸入並記錄輸出、照片、工具版本與測試條件。

## 各 Lab 的驗證重點

| Lab | 主要檢查 | 尚待補齊 |
| --- | --- | --- |
| 01 | 多工選擇、BCD 修正、加法進位 | 完整組合輸入自動檢查 |
| 02 | 計數與秒／分／時邊界、reset | clock constraints、按鍵彈跳與長時間誤差 |
| 03 | 加減與乘法位寬、溢位、暫存器邊界 | 自動比對算術參考模型 |
| 04 | FSM 轉移、序列重疊、移位方向 | 非法狀態、reset 與輸入時序 |
| 05 | 寫入／讀回、位址、單埠／雙埠行為 | 同址讀寫語意及跨埠衝突 |
| 06 | 指令、暫存器、ROM 與逐步執行 | 自動化指令測試與完整波形 |
| 07 | ARM userspace 啟動與 Hello World | 原始 Makefile、Linux image 與 compiler log |
| 08 | HPS bridge、位址映射、LED／七段輸出 | 重新產生 Qsys、核對 header 與完整板端重測 |

本次公開整理未操作實體 FPGA。新驗證結果應附對應 commit、命令、輸入、輸出及限制，避免把歷史照片當作目前版本的新測試。
