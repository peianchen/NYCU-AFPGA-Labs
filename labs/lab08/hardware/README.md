# Lab 08 HPS FPGA Hardware

[回到 Lab 08](../README.md)

## 目的

以 Qsys／Platform Designer 配置 HPS、lightweight bridge、PIO LED 與七段顯示自訂元件。

## 主要檔案

- [`Makefile`](Makefile): project file
- [`hps_0.h`](hps_0.h): H
- [`soc_system.qpf`](soc_system.qpf): QPF
- [`soc_system.qsf`](soc_system.qsf): QSF
- [`soc_system.qsys`](soc_system.qsys): QSYS
- [`soc_system_timing.sdc`](soc_system_timing.sdc): SDC
- [`soc_system.sopcinfo`](soc_system.sopcinfo): SOPCINFO
- [`ghrd_top.v`](ghrd_top.v): V
- [`SEG7_LUT.v`](SEG7_LUT.v): V

## 驗證重點

重新產生系統後比對 address map、top-level ports、pin assignments 與 HPS handoff。

## 開啟與執行

1. 用 Quartus 開啟 `soc_system.qpf`。
2. 在 Platform Designer 開啟 `soc_system.qsys` 並檢查 address map。
3. 重新 Generate HDL，確認 HPS handoff 與 `hps_0.h` 同步。
4. 執行 Analysis & Synthesis、full compilation，再下載 SOF 到 DE1-SoC。

## 證據與結果

本專案的原理、I/O、報告結果與實機圖片集中在 [Lab 08 README](../README.md#實機結果與圖集)。圖片來自原始課程報告，不代表本次文件整理已重新執行 compilation、timing analysis 或上板測試。

## 已知限制

- 這是課程期間保存的 Quartus／Qsys 工程；工具版本、IP catalog 與 HPS handoff 可能需要重新產生。
- `db/`、`incremental_db/`、`output_files/` 與 generated Qsys output 屬可再生檔案，未納入版本控制。
- 修改 Qsys address map 後，必須同步更新 software header、重新編譯並重新上板驗證。
