# Lab 02 Part 04 LPM Counter

[回到 Lab 02](../../README.md)

## 目的

整合 Quartus LPM counter、BDF 與 Verilog wrapper。

## 主要檔案

- [`lab2_4.bdf`](lab2_4.bdf): BDF
- [`counter.qip`](counter.qip): QIP
- [`lab2_4.qpf`](lab2_4.qpf): QPF
- [`lab2_4.qsf`](lab2_4.qsf): QSF
- [`counter.v`](counter.v): V
- [`counter_bb.v`](counter_bb.v): V
- [`counter_inst.v`](counter_inst.v): V
- [`Verilog1.v`](Verilog1.v): V

## 驗證重點

確認 BDF instance、QIP 與 top-level port 在 Quartus 中解析一致。

## 開啟與執行

1. 用相容版本 Quartus 開啟本資料夾中的 `.qpf`。
2. 檢查 device、top-level 與 pin assignments。
3. 先執行 Analysis & Synthesis；有 `.vwf` 時再執行 waveform simulation。
4. Full compilation 成功後下載到 DE1-SoC，依驗證重點操作開關與按鍵。

## 證據與結果

本專案的原理、I/O、報告結果與實機圖片集中在 [Lab 02 README](../../README.md#實機結果與圖集)。圖片來自原始課程報告，不代表本次文件整理已重新執行 compilation、timing analysis 或上板測試。

## 已知限制

- 這是課程期間保存的 Quartus 工程；工具版本、IP catalog 與絕對輸出路徑可能需要在新環境重新指定。
- `db/`、`incremental_db/`、`output_files/` 與 simulation output 屬可再生檔案，未納入版本控制。
- 修改 source 後，必須重新編譯並重新驗證，不能沿用報告照片宣稱新版硬體已通過。
