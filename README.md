# NYCU-AFPGA

Advanced Programmable Logic System Design and Application · DE1-SoC · Verilog · HPS/Linux

[Lab 索引](docs/LABS.md) · [驗證與重現](docs/VALIDATION.md) · [公開版本說明](docs/PUBLICATION.md) · [個人網站](https://peianchen.github.io/peian-chen/#coursework)

這個 repository 整理「進階可程式邏輯系統設計與應用」的八組 FPGA 實驗，內容涵蓋組合邏輯、循序電路、算術單元、有限狀態機、FPGA 記憶體、簡易處理器，以及 DE1-SoC 的 HPS/FPGA 整合。

本版本已將原始 Quartus 專案、報告中的實機照片與詳細分析整合在同一套目錄。README 中的「實機驗證」表示原始報告保存了對應照片；不等同於目前環境重新編譯、重新量測或重新上板驗證。

## Repository 結構

```text
labs/
  lab01/
    README.md       # 實驗目的、設計、結果與分析
    assets/         # 從原始 Word 報告抽出的驗證圖片
    projects/       # 各 Part 的 Quartus 專案
  ...
  lab08/
    hardware/       # Quartus、Qsys 與 FPGA top-level
    software/       # HPS Linux C 程式
docs/LABS.md        # 八組 Lab 的快速索引
tools/              # 報告圖片擷取與文件維護工具
```

## Lab 總覽

| Lab | 主題 | 主要證據 | 詳細說明 |
| --- | --- | --- | --- |
| 01 | 組合邏輯、BCD 轉換與加法 | 7 張 DE1-SoC 實機照片、RTL Viewer | [Lab 01](labs/lab01/README.md) |
| 02 | 正反器、計數器與即時時鐘 | 8 張時間邊界照片、RTL Viewer、VWF | [Lab 02](labs/lab02/README.md) |
| 03 | 加減法器與乘法器 | 12 張乘加結果照片、RTL Viewer | [Lab 03](labs/lab03/README.md) |
| 04 | 暫存器、移位器與 FSM | 18 張狀態轉移照片、RTL Viewer | [Lab 04](labs/lab04/README.md) |
| 05 | 單埠／雙埠 RAM | 7 張寫入讀回照片、Quartus Programmer、RTL Viewer | [Lab 05](labs/lab05/README.md) |
| 06 | 簡易處理器與指令 ROM | 19 張逐步執行照片、RTL Viewer | [Lab 06](labs/lab06/README.md) |
| 07 | DE1-SoC HPS 與 Linux | Hello World source、Linux console | [Lab 07](labs/lab07/README.md) |
| 08 | Qsys HPS-FPGA 整合 | 3 張 LED／七段顯示實機照片 | [Lab 08](labs/lab08/README.md) |

完整專案與檔案對照請見 [Detailed Lab Index](docs/LABS.md)。

## 硬體與工具

- 開發板：Terasic DE1-SoC（Cyclone V SoC）
- FPGA 工具：Intel/Altera Quartus，部分專案源自 Quartus II 13.1
- HDL：Verilog；另含 BDF、LPM/IP、MIF 與 VWF
- SoC 工具：Qsys／Platform Designer、SoC EDS、ARM GNU cross toolchain
- HPS 作業環境：DE1-SoC Linux userspace
- 腳位參考：`DE1_pin_assignments.csv`、`DE1_SoC_pin_assignments.csv`

## 使用方式

1. 進入目標 Lab 的 `projects/`，閱讀該子專案 README。
2. 用相容版本 Quartus 開啟 `.qpf`。
3. 檢查 device、top-level、pin assignments 與 IP 路徑。
4. 先執行 Analysis & Synthesis，再視需要執行 simulation、full compilation 與上板測試。
5. 以各 Lab README 的測試矩陣比對波形或實機輸出。

## 驗證狀態與限制

- Repository 保存原始 HDL、Quartus 專案、VWF、Qsys/HPS source 與報告結果圖。
- `Lab 01 Part 01` 已用 Quartus Prime 25.1 Standard 在純 ASCII 暫存路徑完成 full compilation：`0 errors, 248 warnings`。這只證明該代表工程可由目前工具鏈建置，不代表其他 Lab 已逐一重建。
- 該次 timing analyzer 沒有找到 SDC 或 clock constraint，因此不能據此宣稱 timing closure；本次也沒有重新執行 FPGA programming 或實機量測。
- Quartus 25.1 無法直接以目前含中文與空白的完整路徑建立舊工程；若重建失敗，請先把目標子專案複製到純 ASCII 工作路徑。
- 舊的個人模擬輸出路徑已改為相對路徑；本機 programmer chain 路徑已移除。仍需依目前的 Quartus/IP 版本檢查工程設定。
- `lab01/projects/archive-registered-stub` 是不完整歷史資料；完整 Lab 1 Part 7 BCD adder 位於 `part07-bcd-adder`。
- Lab 7 報告未保存獨立 source folder，因此只提供報告中可確認的程式與 Linux 執行證據。

## 圖片來源與隱私

`labs/labXX/assets/` 保存人工檢視過的實驗結果圖片，不包含報告封面或整份作業文件。公開歷史由整理後的檔案重新建立。重新擷取圖片時，請先輸出到本機檢查資料夾，檢查圖片文字與 metadata 後才選入 repository：

```powershell
python tools/extract_report_assets.py --source-dir <local-report-folder> --repository <local-review-folder>
```

原始報告本身不納入 repository。
