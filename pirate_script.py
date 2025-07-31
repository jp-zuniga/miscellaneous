"""
pirate script, arrr!
"""

import os


for dirpath, _, files in os.walk(
    os.path.join(os.path.dirname(__file__), "Better Call Saul")
):
    for file in files:
        if file.endswith(".mkv"):
            path = f"{dirpath}/{file}"
            new = f"{dirpath}/" + file.replace(
                "Better Call Saul (2015) - ", ""
            ).replace(" (1080p BluRay x265 Silence)", "")

            input(f"Confirm:\nFrom: {path}\nTo: {new}")
            os.rename(path, new)
