"""
Calculates a subnet table from:
  - a base IP,
  - number of subnets,
  - and hosts per subnet.
"""

from sys import argv, exit

COL_WIDTH = 13
HEADERS = ["Item", "Subnet ID", "First IP", "Last IP", "Broadcast"]


class Subnet:
    def __init__(
        self,
        subnet_id: str,
        first_ip: str,
        last_ip: str,
        broadcast_addr: str,
    ) -> None:
        self.subnet_id = subnet_id
        self.first_ip = first_ip
        self.last_ip = last_ip
        self.broadcast_addr = broadcast_addr


def calculate_table(base_ip: str, num_subnets: int, hosts_per_subnet: int) -> list[Subnet]:
    table: list[Subnet] = []
    ip: list[int] = [int(octet) for octet in base_ip.split(".")]

    for _ in range(1, num_subnets + 1):
        subnet_id = ".".join(str(octet) for octet in ip)
        first_ip = ".".join(
            str(octet) if i != 3 else str(octet + 1) for i, octet in enumerate(ip)
        )

        last_ip = ""
        broadcast_addr = ""

        for host in range(1, hosts_per_subnet + 1):
            if ip[3] == 255:
                ip[3] = 0
                ip[2] += 1
            if ip[2] == 255:
                ip[2] = 0
                ip[1] += 1
            if ip[1] == 255:
                ip[1] = 0
                ip[0] += 1
            ip[3] += 1

            if host == hosts_per_subnet - 2:
                last_ip = ".".join(str(octet) for octet in ip)
            if host == hosts_per_subnet - 1:
                broadcast_addr = ".".join(str(octet) for octet in ip)

        table.append(Subnet(subnet_id, first_ip, last_ip, broadcast_addr))

    return table


def print_table(subnets: list[Subnet]) -> None:
    header_row = (
        f"{HEADERS[0].center(COL_WIDTH // 2)} | "
        f"{HEADERS[1].center(COL_WIDTH)} | "
        f"{HEADERS[2].center(COL_WIDTH)} | "
        f"{HEADERS[3].center(COL_WIDTH)} | "
        f"{HEADERS[4].center(COL_WIDTH)} | "
    )

    print(f"\n{header_row}")
    print("-" * (len(header_row) - 1))

    for i, subnet in enumerate(subnets):
        print(
            f"{str(f'{i + 1}.').center(COL_WIDTH // 2)} | "
            f"{subnet.subnet_id.center(COL_WIDTH)} | "
            f"{subnet.first_ip.center(COL_WIDTH)} | "
            f"{subnet.last_ip.center(COL_WIDTH)} | "
            f"{subnet.broadcast_addr.center(COL_WIDTH)} | "
        )


def main(args: list[str]) -> None:
    if len(args) != 4:
        print("Usage:")
        print("  python ip-table.py <base-ip> <num-subnets> <hosts-per-subnet>")
        print("Example:")
        print("  python ip-table.py 192.168.1.0 4 256")
        exit(1)

    _, ip, subnets, hosts = args
    try:
        print_table(calculate_table(ip, int(subnets), int(hosts)))
    except ValueError:
        print("Error: <num_subnets> and <hosts-per-subnet> must be integers.")


if __name__ == "__main__":
    main(argv)
