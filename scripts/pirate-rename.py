"""
pirate script, arrr!
"""

import os
import sys


def rename(subdir: str, prefix: str, suffix: str, ext: str = ".mkv") -> None:
    for dirpath, _, files in os.walk(os.path.join(os.path.dirname(__file__), subdir)):
        for file in files:
            if file.endswith(ext):
                og = os.path.join(dirpath, file)
                new = os.path.join(
                    dirpath, file.replace(prefix, "").replace(suffix, "")
                )

                input(f"Confirm:\nFrom: {og}\nTo: {new}")
                os.rename(og, new)


def main() -> None:
    if len(sys.argv) != 4:
        print("Usage: python pirate-rename.py [ARGS]\n")
        print("  ARGS:")
        print("    - subdir: Directory where files are located")
        print("    - prefix: Initial part of file name to be removed")
        print("    - suffix: Trailing part of file name to be removed")
        print("    - ext:    Extension of desired files (optional, defaults to '.mkv')")
        sys.exit(1)

    rename(
        subdir=sys.argv[1],
        prefix=sys.argv[2],
        suffix=sys.argv[3],
        ext=sys.argv[4] if len(sys.argv) == 5 else ".mkv",
    )


if __name__ == "__main__":
    main()
