"""
Takes an IPv4 address and converts it:
from decimal to binary, or from binary to decimal.
"""

import sys


def ip_to_bin(address: str) -> str:
    bin_octs: list[str] = []
    dec_octs: list[str] = address.split(".")

    for octet in dec_octs:
        bin_octs.append(f"{int(octet):08b}")

    return ".".join(bin_octs)


def ip_to_dec(address: str) -> str:
    dec_octs: list[str] = []
    bin_octs: list[str] = address.split(".")

    for octet in bin_octs:
        dec_octs.append(str(int(octet, 2)))

    return ".".join(dec_octs)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python ip_converter.py [-d|-b] <ip_address>")
        print("  -d  Convert binary IP to decimal")
        print("  -b  Convert decimal IP to binary")
        sys.exit(1)

    if sys.argv[1] == "-d":
        print(ip_to_dec(sys.argv[2]))
    elif sys.argv[1] == "-b":
        print(ip_to_bin(sys.argv[2]))
    else:
        print("Invalid option. Use -d or -b")
