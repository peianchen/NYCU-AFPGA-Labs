# Detailed Lab Index

本索引提供八組實驗的專案入口、主要原始檔與證據狀態。詳細原理、操作、結果與限制請進入各 Lab README。

## Lab 01 組合邏輯與 BCD 加法

| 專案 | 主要檔案 | 內容 |
| --- | --- | --- |
| [`part01-multiplexer`](../labs/lab01/projects/part01-multiplexer/) | `LAB1_1.v` | 多工器與開關選擇 |
| [`part03-multiplexer-hardware`](../labs/lab01/projects/part03-multiplexer-hardware/) | `LAB1_3.v` | 多工器硬體輸出 |
| [`part04-seven-segment`](../labs/lab01/projects/part04-seven-segment/) | `LAB1_4.v` | 七段顯示器解碼 |
| [`part05-bcd-correction`](../labs/lab01/projects/part05-bcd-correction/) | `LAB1_5.v` | BCD 比較與修正 |
| [`part06-full-adder`](../labs/lab01/projects/part06-full-adder/) | `LAB1_6.v` | 1-bit full adder |
| [`part07-bcd-adder`](../labs/lab01/projects/part07-bcd-adder/) | `lab_1.v` | 完整一位 BCD 加法器 |
| [`archive-registered-stub`](../labs/lab01/projects/archive-registered-stub/) | `registered.v` | 不完整歷史資料，非 Part 7 完整答案 |

證據：[Lab 01 說明與圖集](../labs/lab01/README.md#實機結果與圖集)

## Lab 02 時序邏輯與時鐘

| 專案 | 主要檔案 | 內容 |
| --- | --- | --- |
| [`part01-latches-flipflops`](../labs/lab02/projects/part01-latches-flipflops/) | `Lab2_1.v`, `.vwf` | D latch、正／負緣 FF |
| [`part02-t-flipflop`](../labs/lab02/projects/part02-t-flipflop/) | `lab2_2.v`, `Waveform.vwf` | T flip-flop 計數器 |
| [`part03-counter`](../labs/lab02/projects/part03-counter/) | `lab2_3.v` | 16-bit counter |
| [`part04-lpm-counter`](../labs/lab02/projects/part04-lpm-counter/) | `counter.v`, `lab2_4.bdf` | LPM/BDF counter |
| [`part05-decimal-counter`](../labs/lab02/projects/part05-decimal-counter/) | `lab2_5.v` | 1 Hz 十進位計數器 |
| [`part06-modulo-counter`](../labs/lab02/projects/part06-modulo-counter/) | `lab2_6.v` | 可串接模 N counter |
| [`part07-time-of-day-clock`](../labs/lab02/projects/part07-time-of-day-clock/) | `lab2_7.v` | 24 小時時分秒時鐘 |

證據：[Lab 02 說明與圖集](../labs/lab02/README.md#實機結果與圖集)

## Lab 03 算術電路

| 專案 | 主要檔案 | 內容 |
| --- | --- | --- |
| [`part01-ripple-carry-adder`](../labs/lab03/projects/part01-ripple-carry-adder/) | `lab3_1.v` | 8-bit ripple-carry adder |
| [`part02-registered-adder`](../labs/lab03/projects/part02-registered-adder/) | `lab3_2.v` | 暫存輸入的加減法器 |
| [`part04-four-bit-multiplier`](../labs/lab03/projects/part04-four-bit-multiplier/) | `lab3_4.v` | 4 × 4-bit multiplier |
| [`part05-multiplier-unit`](../labs/lab03/projects/part05-multiplier-unit/) | `lab3_5.v` | 8-bit 部分積與加法 |
| [`part06-eight-bit-multiplier`](../labs/lab03/projects/part06-eight-bit-multiplier/) | `lab3_6.v` | `(A × B) + (C × D)` |

證據：[Lab 03 說明與圖集](../labs/lab03/README.md#實機結果與圖集)

## Lab 04 暫存器與有限狀態機

| 專案 | 主要檔案 | 內容 |
| --- | --- | --- |
| [`part01-register`](../labs/lab04/projects/part01-register/) | `lab4_1.v` | enable-controlled register |
| [`part02-sequence-detector`](../labs/lab04/projects/part02-sequence-detector/) | `LAB4_2.v` | 連續四個 0／1 的 sequence detector |
| [`part03-shift-register`](../labs/lab04/projects/part03-shift-register/) | `lab4_3.v` | 4-bit shift register |
| [`part04-ten-state-fsm`](../labs/lab04/projects/part04-ten-state-fsm/) | `lab4_4.v` | 保持、+1、+2、-1 的模 10 FSM |

證據：[Lab 04 說明與圖集](../labs/lab04/README.md#實機結果與圖集)

## Lab 05 FPGA 記憶體

| 專案 | 主要檔案 | 內容 |
| --- | --- | --- |
| [`part01-lpm-single-port-ram`](../labs/lab05/projects/part01-lpm-single-port-ram/) | `lab5_1.v`, `ramlpm.v` | LPM single-port RAM |
| [`part02-inferred-ram`](../labs/lab05/projects/part02-inferred-ram/) | `lab5_2.v` | Verilog array 推導 RAM |
| [`part04-dual-port-ram`](../labs/lab05/projects/part04-dual-port-ram/) | `lab5_4.v`, `ram_2port.v` | LPM dual-port RAM |
| [`part05-single-port-ram-mux`](../labs/lab05/projects/part05-single-port-ram-mux/) | `lab5_5.v`, `ramlpm.v` | 單埠 RAM 與顯示 MUX |

證據：[Lab 05 說明與圖集](../labs/lab05/README.md#實機結果與圖集)

## Lab 06 簡易處理器

| 專案 | 主要檔案 | 內容 |
| --- | --- | --- |
| [`part01-processor`](../labs/lab06/projects/part01-processor/) | `lab6_1.v` | 開關輸入指令／資料的 multi-cycle processor |
| [`part02-processor-rom`](../labs/lab06/projects/part02-processor-rom/) | `lab6_2.v`, `lpmrom.mif` | 加入 PC 與 instruction ROM |

證據：[Lab 06 說明與圖集](../labs/lab06/README.md#實機結果與圖集)

## Lab 07 HPS Linux

Lab 7 沒有獨立 source folder。報告可確認 ARM/HPS cross-compilation、儲存裝置掛載、Linux shell 執行與 `Hello World!` 輸出，但不足以證明 HPS-to-FPGA bridge。

證據：[Lab 07 說明、source 與 console](../labs/lab07/README.md#實機結果與圖集)

## Lab 08 HPS FPGA 整合

| 專案 | 主要檔案 | 內容 |
| --- | --- | --- |
| [`hardware`](../labs/lab08/hardware/) | `soc_system.qsys`, `ghrd_top.v`, `soc_system.qsf` | HPS、lightweight bridge、PIO、七段顯示硬體平台 |
| [`software`](../labs/lab08/software/) | `main.c`, `hps_0.h`, `Makefile` | `/dev/mem` + `mmap()` 控制 FPGA LED／七段顯示器 |

證據：[Lab 08 說明與圖集](../labs/lab08/README.md#實機結果與圖集)
