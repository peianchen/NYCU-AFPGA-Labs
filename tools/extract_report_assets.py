"""Extract public result images from the original Lab DOCX reports.

The reports remain outside this repository because they contain student details.
Only embedded result images are copied into each Lab's assets directory.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path
from zipfile import ZipFile


def image_number(path: str) -> int:
    match = re.search(r"(\d+)$", Path(path).stem)
    if not match:
        raise ValueError(f"Cannot determine image number from {path}")
    return int(match.group(1))


def target_name(lab: int, number: int, highest: int, suffix: str) -> str:
    if lab <= 6 and number == highest and suffix.lower() == ".png":
        return "rtl-view.png"
    if lab == 7:
        return "source-code.png" if suffix.lower() == ".png" else "linux-console.jpg"
    return f"result-{number:02d}{suffix.lower().replace('.jpeg', '.jpg')}"


def find_report(source_dir: Path, pattern: str, lab: int) -> Path:
    matches = sorted(source_dir.glob(pattern.format(lab=lab)))
    if len(matches) != 1:
        names = ", ".join(path.name for path in matches) or "none"
        raise FileNotFoundError(
            f"Expected exactly one report for Lab {lab}; found: {names}"
        )
    return matches[0]


def extract(source_dir: Path, repository: Path, pattern: str) -> None:
    for lab in range(1, 9):
        report = find_report(source_dir, pattern, lab)
        destination = repository / "labs" / f"lab{lab:02d}" / "assets"
        destination.mkdir(parents=True, exist_ok=True)

        with ZipFile(report) as archive:
            media = [name for name in archive.namelist() if name.startswith("word/media/")]
            highest = max(image_number(name) for name in media)
            for name in sorted(media, key=image_number):
                source_name = Path(name)
                output_name = target_name(lab, image_number(name), highest, source_name.suffix)
                (destination / output_name).write_bytes(archive.read(name))
                print(f"Lab {lab}: {source_name.name} -> {output_name}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source-dir", type=Path, required=True)
    parser.add_argument("--repository", type=Path, default=Path.cwd())
    parser.add_argument(
        "--pattern",
        default="lab{lab}_*.docx",
        help="Glob pattern for one report per Lab; use {lab} as the Lab number.",
    )
    args = parser.parse_args()
    extract(args.source_dir.resolve(), args.repository.resolve(), args.pattern)


if __name__ == "__main__":
    main()
