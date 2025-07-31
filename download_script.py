"""
lil script to auto download files from an rss feed.
"""

from os import path, walk
from time import sleep
from webbrowser import open as open_link


def find_indices(feed: str) -> list[tuple[int, int]]:
    start_indices: list[tuple[int, int]] = []
    i = 0
    j = 0

    while True:
        i = feed.find("<enclosure url=", i)
        j = feed.find("<item><title", j)
        if i == -1 and j == -1:
            break

        start_indices.append((i, j))
        i += 1
        j += 1

    return start_indices


def get_episodes(feed: str, start_indices: list[tuple[int, int]]) -> dict[str, str]:
    episodes: dict[str, str] = {}

    start_indices.reverse()

    for link, title in start_indices:
        link_start = feed.find('"', link) + 1
        link_end = feed.find('"', link_start)

        title_start = feed.find(">", title) + 8
        title_end = feed.find("</", title_start)

        episodes[feed[title_start:title_end].strip()] = feed[
            link_start:link_end
        ].replace("&amp;", "&")

    return episodes


def download_episodes(episodes: dict[str, str]) -> None:
    initial_wait = 30
    recheck_wait_time = 3
    download_path = path.join(path.expanduser("~"), "Downloads")

    for index, title in enumerate(episodes.keys()):
        open_link(episodes[title], new=2, autoraise=False)
        print(f"\nStarting download: '{title}'" + f" (#{index + 1}/{len(episodes)})...")

        sleep(initial_wait)

        k = 0
        while True:
            if k % recheck_wait_time != 0:
                continue

            if any(
                file.endswith(".part")
                for _, _, files in walk(download_path)
                for file in files
            ):
                k += 1
                print("Still downloading...")
                sleep(recheck_wait_time)
            else:
                print("Download complete!")
                break

    print("\nAll done!!!")


def main() -> None:
    file = "worldsbeyondnumber"

    with open(file, mode="r", encoding="utf-8") as rss_file:
        feed = rss_file.read()

    episodes = get_episodes(feed, find_indices(feed))
    download_episodes(episodes)


if __name__ == "__main__":
    main()
