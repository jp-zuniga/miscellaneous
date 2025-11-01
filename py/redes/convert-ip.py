"""
Takes an IPv4 address and converts it from:
from decimal to binary, or vice-versa.
"""

from sys import argv, exit


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


def main(args: list[str]) -> None:
    if len(args) != 3:
        print("Usage:")
        print("  python convert-ip.py [option] <ip>\n")
        print("Options:")
        print("  -b: Convert decimal IP to binary")
        print("  -d: Convert binary  IP to decimal")
        exit(1)

    if args[1] == "-d":
        print(ip_to_dec(args[2]))
    elif args[1] == "-b":
        print(ip_to_bin(args[2]))
    else:
        print("Invalid option. Use -d or -b")


if __name__ == "__main__":
    main(argv)
