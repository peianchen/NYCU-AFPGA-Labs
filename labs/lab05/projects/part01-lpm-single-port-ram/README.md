# Lab 05 Part 01 LPM Single Port RAM

[回到 Lab 05](../../README.md)

## 目的

使用 Quartus LPM 建立 32×4-bit single-port RAM 與板端顯示。

## 主要檔案

- [`ramlpm.qip`](ramlpm.qip): QIP
- [`lab5_1.qpf`](lab5_1.qpf): QPF
- [`lab5_1.qsf`](lab5_1.qsf): QSF
- [`lab5_1.v`](lab5_1.v): V
- [`ramlpm.v`](ramlpm.v): V
- [`ramlpm_bb.v`](ramlpm_bb.v): V
- [`ramlpm_inst.v`](ramlpm_inst.v): V

## 驗證重點

寫入多個地址，關閉 write enable 後逐一讀回。

## 開啟與執行

1. 用相容版本 Quartus 開啟本資料夾中的 `.qpf`。
2. 檢查 device、top-level 與 pin assignments。
3. 先執行 Analysis & Synthesis；有 `.vwf` 時再執行 waveform simulation。
4. Full compilation 成功後下載到 DE1-SoC，依驗證重點操作開關與按鍵。

## 證據與結果

本專案的原理、I/O、報告結果與實機圖片集中在 [Lab 05 README](../../README.md#實機結果與圖集)。圖片來自原始課程報告，不代表本次文件整理已重新執行 compilation、timing analysis 或上板測試。

## 已知限制

- 這是課程期間保存的 Quartus 工程；工具版本、IP catalog 與絕對輸出路徑可能需要在新環境重新指定。
- `db/`、`incremental_db/`、`output_files/` 與 simulation output 屬可再生檔案，未納入版本控制。
- 修改 source 後，必須重新編譯並重新驗證，不能沿用報告照片宣稱新版硬體已通過。
