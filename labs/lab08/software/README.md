# Lab 08 HPS Linux Software

[回到 Lab 08](../README.md)

## 目的

以 Linux `/dev/mem` 與 `mmap()` 存取 lightweight HPS-to-FPGA bridge，驅動 LED 與七段顯示器。

## 主要檔案

- [`Makefile`](Makefile): project file
- [`main.c`](main.c): C
- [`hps_0.h`](hps_0.h): H

## 驗證重點

執行時確認 one-hot LED 往返移動，完整往返後七段 counter 增加。

## 開啟與執行

1. 安裝並啟用 Intel SoC EDS／ARM cross toolchain。
2. 確認 `SOCEDS_DEST_ROOT` 與硬體產生的 `hps_0.h` 一致。
3. 執行 `make` 產生 ARM executable。
4. 將執行檔傳到 DE1-SoC Linux，使用具有 `/dev/mem` 權限的帳號執行。

## 證據與結果

本專案的原理、I/O、報告結果與實機圖片集中在 [Lab 08 README](../README.md#實機結果與圖集)。圖片來自原始課程報告，不代表本次文件整理已重新執行 compilation、timing analysis 或上板測試。

## 已知限制

- `hps_0.h` 的 base address 必須和實際下載的 FPGA bitstream 完全一致。
- 程式透過 `/dev/mem` 存取實體位址，執行帳號需要對應權限。
- 本次只整理來源與既有報告證據，未在 DE1-SoC Linux 上重新 cross-compile 或執行。
