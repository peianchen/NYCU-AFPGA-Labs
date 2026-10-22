"""Generate project-level README files from reviewed project metadata."""

from __future__ import annotations

from pathlib import Path


PROJECTS = {
    "lab01/projects/part01-multiplexer": ("Lab 01 Part 01 Multiplexer", "以開關選擇輸入並觀察多工器輸出，建立組合邏輯與條件選擇的基礎。", "逐一切換 select 與 data inputs，確認 LED 輸出符合 truth table。"),
    "lab01/projects/part03-multiplexer-hardware": ("Lab 01 Part 03 Multiplexer Hardware", "把多工器設計配置到 DE1-SoC 開關與 LED，驗證 HDL 與實體 I/O 的對應。", "覆蓋 select 的所有組合，確認硬體輸出與選定輸入一致。"),
    "lab01/projects/part04-seven-segment": ("Lab 01 Part 04 Seven Segment Decoder", "將 4-bit 值轉成 active-low 七段顯示器碼。", "輸入 0 到 F，檢查每個 segment pattern 與預期字形。"),
    "lab01/projects/part05-bcd-correction": ("Lab 01 Part 05 BCD Correction", "檢查 BCD 合法範圍並對超過 9 的值執行十進位修正與顯示。", "測試 0、9、10、15 與需要修正的加法結果。"),
    "lab01/projects/part06-full-adder": ("Lab 01 Part 06 Full Adder", "以邏輯方程實作 sum 與 carry-out，作為多位元 ripple-carry adder 的基本單元。", "遍歷 a、b、carry-in 的八種輸入組合。"),
    "lab01/projects/part07-bcd-adder": ("Lab 01 Part 07 BCD Adder", "整合 full adder、比較器、BCD correction、multiplexer 與七段顯示器，完成兩個一位 BCD 數字相加。", "驗證一般和、十位進位、最大合法結果與非法 BCD 輸入。"),
    "lab01/projects/archive-registered-stub": ("Lab 01 Archived Register Stub", "保存原始不完整的 registered 模組與 Quartus 專案設定，僅供追溯。", "目前缺少可對應 top-level 的完整 source，不應視為可直接建置的 Part 7。"),
    "lab02/projects/part01-latches-flipflops": ("Lab 02 Part 01 Latches and Flip Flops", "比較 level-sensitive D latch、positive-edge D FF 與 negative-edge D FF。", "使用三份 VWF 觀察輸出在 level、上升緣與下降緣的更新差異。"),
    "lab02/projects/part02-t-flipflop": ("Lab 02 Part 02 T Flip Flop", "以 T flip-flop 建立可顯示的循序計數行為。", "以 VWF 或按鍵 clock 檢查 T=0 保持、T=1 翻轉。"),
    "lab02/projects/part03-counter": ("Lab 02 Part 03 Counter", "以 16-bit T flip-flop chain 建立多位元 counter。", "檢查低位翻轉頻率與高位 carry propagation。"),
    "lab02/projects/part04-lpm-counter": ("Lab 02 Part 04 LPM Counter", "整合 Quartus LPM counter、BDF 與 Verilog wrapper。", "確認 BDF instance、QIP 與 top-level port 在 Quartus 中解析一致。"),
    "lab02/projects/part05-decimal-counter": ("Lab 02 Part 05 Decimal Counter", "將 50 MHz clock 分頻為約 1 Hz，驅動十進位 counter 與七段顯示器。", "觀察 0 到 9 後回捲，並檢查 1 Hz 節奏。"),
    "lab02/projects/part06-modulo-counter": ("Lab 02 Part 06 Modulo Counter", "以可串接模 N counter 組合多位 BCD 顯示。", "測試每一位的 modulus 與 carry-out 是否只在邊界產生。"),
    "lab02/projects/part07-time-of-day-clock": ("Lab 02 Part 07 Time of Day Clock", "以六級 counter 實作 24 小時制的時、分、秒與設定功能。", "驗證 00:24:59、08:59:59、23:59:59 等跨欄位邊界。"),
    "lab03/projects/part01-ripple-carry-adder": ("Lab 03 Part 01 Ripple Carry Adder", "由 1-bit full adders 組成 8-bit ripple-carry adder，並暫存板端輸入。", "測試 0x00+0x00、0xFF+0x01 與 carry chain。"),
    "lab03/projects/part02-registered-adder": ("Lab 03 Part 02 Registered Add Subtract", "以 input registers、8-bit adder/subtractor 與七段顯示器組成可操作算術單元。", "分別測試加法、減法、carry 與 borrow 邊界。"),
    "lab03/projects/part04-four-bit-multiplier": ("Lab 03 Part 04 Four Bit Multiplier", "以 partial products 與 4-bit adders 實作組合式乘法器。", "測試 0×N、1×N、F×F 並比對 8-bit product。"),
    "lab03/projects/part05-multiplier-unit": ("Lab 03 Part 05 Multiplier Unit", "把 8-bit partial-product generation 與多級加法串接成較寬乘法資料路徑。", "確認各 partial product 位移位置與最終 carry。"),
    "lab03/projects/part06-eight-bit-multiplier": ("Lab 03 Part 06 Eight Bit Multiply Add", "計算 `(A × B) + (C × D)`，以四組輸入暫存器、兩組 multiplier 與 16-bit adder 組成。", "以 0xFF×0xFF=0xFE01 及四組全 0xFF 的 overflow case 驗證。"),
    "lab04/projects/part01-register": ("Lab 04 Part 01 Register", "實作具有 enable 的同步暫存器，區分 load 與 hold。", "在 enable=0/1 下跨越多個 clock edge，確認 hold 與更新行為。"),
    "lab04/projects/part02-sequence-detector": ("Lab 04 Part 02 Sequence Detector", "以九狀態 FSM 偵測連續四個 0 或連續四個 1。", "測試 0000、1111、交錯序列與偵測後持續輸入。"),
    "lab04/projects/part03-shift-register": ("Lab 04 Part 03 Shift Register", "以 4-bit right-shift register 保存 serial input 的最近四個 sample。", "逐位輸入已知 pattern，確認 bit order 與 reset。"),
    "lab04/projects/part04-ten-state-fsm": ("Lab 04 Part 04 Ten State FSM", "以十個明確狀態實作保持、+1、+2 與-1 的模 10 狀態機。", "驗證 9→0、8→0、0→9 等環狀邊界。"),
    "lab05/projects/part01-lpm-single-port-ram": ("Lab 05 Part 01 LPM Single Port RAM", "使用 Quartus LPM 建立 32×4-bit single-port RAM 與板端顯示。", "寫入多個地址，關閉 write enable 後逐一讀回。"),
    "lab05/projects/part02-inferred-ram": ("Lab 05 Part 02 Inferred RAM", "以 Verilog array 描述 RAM，讓 synthesis tool 推導 FPGA memory。", "檢查 write clock、read behavior 與 synthesis memory inference。"),
    "lab05/projects/part04-dual-port-ram": ("Lab 05 Part 04 Dual Port RAM", "使用獨立 read/write address 的 LPM dual-port RAM，並自動遞增讀取地址。", "同時改變 read/write address，確認兩個 port 不互相覆蓋。"),
    "lab05/projects/part05-single-port-ram-mux": ("Lab 05 Part 05 Single Port RAM Mux", "以單埠 RAM 配合顯示 MUX 分時呈現寫入資料與讀回資料。", "寫入後必須關閉 write enable 再讀回，避免把 input display 誤判為 memory output。"),
    "lab06/projects/part01-processor": ("Lab 06 Part 01 Multi Cycle Processor", "以 register file、shared bus、ALU 與 control unit 實作手動輸入的 8-bit multi-cycle processor。", "逐 micro-step 檢查 move、immediate、add、subtract 與 done。"),
    "lab06/projects/part02-processor-rom": ("Lab 06 Part 02 Processor with ROM", "加入 program counter 與 instruction ROM，讓處理器依 `lpmrom.mif` 自動取指。", "依 ROM 程式逐步執行，預期結束時 R0=0x09、R1=0x03。"),
    "lab08/hardware": ("Lab 08 HPS FPGA Hardware", "以 Qsys／Platform Designer 配置 HPS、lightweight bridge、PIO LED 與七段顯示自訂元件。", "重新產生系統後比對 address map、top-level ports、pin assignments 與 HPS handoff。"),
    "lab08/software": ("Lab 08 HPS Linux Software", "以 Linux `/dev/mem` 與 `mmap()` 存取 lightweight HPS-to-FPGA bridge，驅動 LED 與七段顯示器。", "執行時確認 one-hot LED 往返移動，完整往返後七段 counter 增加。"),
}


def file_list(project: Path) -> list[Path]:
    extensions = {".qpf", ".qsf", ".v", ".vwf", ".bdf", ".qip", ".mif", ".qsys", ".sopcinfo", ".sdc", ".c", ".h"}
    files = [path for path in project.iterdir() if path.is_file() and (path.suffix.lower() in extensions or path.name == "Makefile")]
    return sorted(files, key=lambda path: (path.suffix.lower(), path.name.lower()))


def workflow(project: Path) -> str:
    if list(project.glob("*.qsys")):
        return """1. 用 Quartus 開啟 `soc_system.qpf`。
2. 在 Platform Designer 開啟 `soc_system.qsys` 並檢查 address map。
3. 重新 Generate HDL，確認 HPS handoff 與 `hps_0.h` 同步。
4. 執行 Analysis & Synthesis、full compilation，再下載 SOF 到 DE1-SoC。"""
    if (project / "Makefile").exists():
        return """1. 安裝並啟用 Intel SoC EDS／ARM cross toolchain。
2. 確認 `SOCEDS_DEST_ROOT` 與硬體產生的 `hps_0.h` 一致。
3. 執行 `make` 產生 ARM executable。
4. 將執行檔傳到 DE1-SoC Linux，使用具有 `/dev/mem` 權限的帳號執行。"""
    return """1. 用相容版本 Quartus 開啟本資料夾中的 `.qpf`。
2. 檢查 device、top-level 與 pin assignments。
3. 先執行 Analysis & Synthesis；有 `.vwf` 時再執行 waveform simulation。
4. Full compilation 成功後下載到 DE1-SoC，依驗證重點操作開關與按鍵。"""


def limitations(relative: str) -> str:
    if relative == "lab08/software":
        return """- `hps_0.h` 的 base address 必須和實際下載的 FPGA bitstream 完全一致。
- 程式透過 `/dev/mem` 存取實體位址，執行帳號需要對應權限。
- 本次只整理來源與既有報告證據，未在 DE1-SoC Linux 上重新 cross-compile 或執行。"""
    if relative == "lab08/hardware":
        return """- 這是課程期間保存的 Quartus／Qsys 工程；工具版本、IP catalog 與 HPS handoff 可能需要重新產生。
- `db/`、`incremental_db/`、`output_files/` 與 generated Qsys output 屬可再生檔案，未納入版本控制。
- 修改 Qsys address map 後，必須同步更新 software header、重新編譯並重新上板驗證。"""
    return """- 這是課程期間保存的 Quartus 工程；工具版本、IP catalog 與絕對輸出路徑可能需要在新環境重新指定。
- `db/`、`incremental_db/`、`output_files/` 與 simulation output 屬可再生檔案，未納入版本控制。
- 修改 source 後，必須重新編譯並重新驗證，不能沿用報告照片宣稱新版硬體已通過。"""


def render(relative: str, title: str, purpose: str, verification: str) -> str:
    project = Path("labs") / relative
    lab = relative.split("/")[0]
    lab_title = lab.replace("lab", "Lab ")
    lab_readme = "../../README.md" if "/projects/" in f"/{relative}/" else "../README.md"
    entries = file_list(project)
    artifacts = "\n".join(f"- [`{path.name}`]({path.name}): {path.suffix.lstrip('.').upper() or 'project file'}" for path in entries)
    return f"""# {title}

[回到 {lab_title}]({lab_readme})

## 目的

{purpose}

## 主要檔案

{artifacts}

## 驗證重點

{verification}

## 開啟與執行

{workflow(project)}

## 證據與結果

本專案的原理、I/O、報告結果與實機圖片集中在 [{lab_title} README]({lab_readme}#實機結果與圖集)。圖片來自原始課程報告，不代表本次文件整理已重新執行 compilation、timing analysis 或上板測試。

## 已知限制

{limitations(relative)}
"""


def main() -> None:
    for relative, metadata in PROJECTS.items():
        output = Path("labs") / relative / "README.md"
        output.write_text(render(relative, *metadata), encoding="utf-8", newline="\n")
        print(output)


if __name__ == "__main__":
    main()
