import sys


class Subred:
    def __init__(
        self,
        id_subred: str,
        primera_ip: str,
        ultima_ip: str,
        dir_broadcast: str,
    ) -> None:
        self.id_subred = id_subred
        self.primera_ip = primera_ip
        self.ultima_ip = ultima_ip
        self.dir_broadcast = dir_broadcast


def calcular_tabla(ip_original: str, subredes: int, hosts: int) -> list[Subred]:
    tabla: list[Subred] = []
    ip: list[int] = [int(octeto) for octeto in ip_original.split(".")]

    for _ in range(1, subredes + 1):
        id_subred = ".".join(str(octeto) for octeto in ip)
        primera_ip = ".".join(
            str(octeto) if i != 3 else str(octeto + 1) for i, octeto in enumerate(ip)
        )

        ultima_ip = ""
        dir_broadcast = ""

        for host in range(1, hosts + 1):
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

            if host == hosts - 2:
                ultima_ip = ".".join(str(octeto) for octeto in ip)
            if host == hosts - 1:
                dir_broadcast = ".".join(str(octeto) for octeto in ip)

        tabla.append(Subred(id_subred, primera_ip, ultima_ip, dir_broadcast))

    return tabla


def print_table(subredes: list[Subred]) -> None:
    counter_width = 9
    col_width = 15
    headers = ["Ítem", "ID Subred", "Primera IP", "Última IP", "Broadcast"]

    # Print header
    header_row = (
        f"{headers[0].center(counter_width)} | "
        f"{headers[1].center(col_width)} | "
        f"{headers[2].center(col_width)} | "
        f"{headers[3].center(col_width)} | "
        f"{headers[4].center(col_width)} | "
    )

    print(f"\n{header_row}")
    print("-" * (len(header_row) - 1))

    for i, subred in enumerate(subredes):
        row = (
            f"{str(f'{i + 1}.').center(counter_width)} | "
            f"{subred.id_subred.center(col_width)} | "
            f"{subred.primera_ip.center(col_width)} | "
            f"{subred.ultima_ip.center(col_width)} | "
            f"{subred.dir_broadcast.center(col_width)} | "
        )

        print(row)


if __name__ == "__main__":
    _, ip, subredes, hosts = sys.argv
    print_table(calcular_tabla(ip, int(subredes), int(hosts)))
