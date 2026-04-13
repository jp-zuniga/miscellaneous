#!/usr/bin/env -S uv run --script

"""
pirate script, arrr!
"""

from os import getcwd
from pathlib import Path
from sys import argv, exit


def rename(subdir: str, prefix: str, suffix: str, ext: str = ".mkv") -> None:
    """
    Renames all files in a given subdirectory matching the given arguments.

    Args:
        subdir: Directory where files are located
        prefix: Initial part of file name to be removed
        suffix: Trailing part of file name to be removed
        ext:    Extension of desired files (optional, defaults to '.mkv')

    """

    wrk_dir = Path(getcwd()).joinpath(subdir)

    if not wrk_dir.exists():
        print(f"{subdir} does not exist!")
        return

    for dirpath, _, files in wrk_dir.walk():
        for file in sorted(files):
            if not file.endswith(ext):
                continue

            og = dirpath.joinpath(file)
            new = dirpath.joinpath(
                file.removeprefix(prefix).removesuffix(ext).removesuffix(suffix).strip()
                + ext,
            )

            input(f"Confirm:\nFrom: {og}\nTo: {new}")
            og.rename(new)


def main(args: list[str]) -> None:
    if len(args) < 4:
        print("Usage:")
        print("  python pirate-rename.py [args]\n")
        print("Args:")
        print("  - subdir: Directory where files are located")
        print("  - prefix: Initial part of file name to be removed")
        print("  - suffix: Trailing part of file name to be removed")
        print("  - ext:    Extension of desired files (optional, defaults to '.mkv')")
        exit(1)

    rename(
        subdir=args[1],
        prefix=args[2],
        suffix=args[3],
        ext=args[4] if len(args) == 5 else ".mkv",
    )


if __name__ == "__main__":
    main(argv)
