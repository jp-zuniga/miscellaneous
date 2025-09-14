"""
Takes a MAC address and converts it:
from hexadecimal to binary, or from binary to hexadecimal.
"""

import sys


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


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python mac_converter.py [-h|-b] <mac_address>")
        print("      -h  Convert hex MAC to binary")
        print("      -b  Convert binary MAC to hex")
        sys.exit(1)

    if sys.argv[1] == "-h":
        print(mac_to_bin(sys.argv[2]))
    elif sys.argv[1] == "-b":
        print(mac_to_hex(sys.argv[2]))
    else:
        print("Invalid option. Use -h or -b")
