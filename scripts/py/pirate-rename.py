"""
pirate script, arrr!
"""

from os import path, walk
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

    for dirpath, _, files in walk(path.join(path.dirname(__file__), subdir)):
        for file in files:
            if file.endswith(ext):
                og = path.join(dirpath, file)
                new = path.join(
                    dirpath, file.replace(prefix, "").replace(suffix, "")
                )

                input(f"Confirm:\nFrom: {og}\nTo: {new}")
                rename(og, new)


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
