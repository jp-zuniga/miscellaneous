"""
Takes a MAC address and converts it:
from hexadecimal to binary, or vice-versa.
"""

from sys import argv, exit


def mac_to_bin(address: str) -> str:
    bin_pairs: list[str] = []
    hex_pairs: list[str] = address.split(":")

    if len(hex_pairs) == 1:
        hex_pairs = address.split("-")

    for octet in hex_pairs:
        bin_pairs.append(f"{int(octet, 16):08b}")

    return ":".join(bin_pairs)


def mac_to_hex(address: str) -> str:
    hex_pairs: list[str] = []
    bin_pairs: list[str] = address.split(":")

    if len(bin_pairs) == 1:
        bin_pairs = address.split("-")

    for octet in bin_pairs:
        hex_pairs.append(f"{int(octet, 2):02x}".upper())

    return ":".join(hex_pairs)


def main(args: list[str]) -> None:
    if len(args) != 3:
        print("Usage:")
        print("  python convert-mac.py [option] <mac>")
        print("Options:")
        print("  -b: Convert binary MAC to hex")
        print("  -h: Convert hex    MAC to binary")
        exit(1)

    if args[1] == "-h":
        print(mac_to_bin(args[2]))
    elif args[1] == "-b":
        print(mac_to_hex(args[2]))
    else:
        print("Invalid option. Use -h or -b")


if __name__ == "__main__":
    main(argv)
