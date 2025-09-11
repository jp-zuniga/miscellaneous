#include <algorithm>
#include <cmath>
#include <iostream>
#include <string>

std::string decimalABinario(int decimal) {
    if (decimal == 0) {
        return "0";
    };

    std::string binario = "";

    while (decimal > 0) {
        binario = std::to_string(decimal % 2) + binario;
        decimal /= 2;
    }

    return binario;
}

std::string decimalAHexadecimal(int decimal) {
    if (decimal == 0) {
        return "0";
    };

    char hexChars[] = "0123456789ABCDEF";
    std::string hexadecimal = "";

    while (decimal > 0) {
        hexadecimal = hexChars[decimal % 16] + hexadecimal;
        decimal /= 16;
    }

    return hexadecimal;
}

int binarioADecimal(std::string binario) {
    int decimal = 0;
    int potencia = 0;

    for (int i = binario.length() - 1; i >= 0; i--) {
        if (binario[i] == '1') {
            decimal += pow(2, potencia);
        }

        potencia++;
    }

    return decimal;
}

int hexadecimalADecimal(std::string hexadecimal) {
    int decimal = 0;
    int potencia = 0;

    for (int i = hexadecimal.length() - 1; i >= 0; i--) {
        int valor;
        char c = toupper(hexadecimal[i]);

        if (c >= '0' && c <= '9') {
            valor = c - '0';
        } else {
            valor = c - 'A' + 10;
        }

        decimal += valor * std::pow(16, potencia);
        potencia++;
    }

    return decimal;
}

int main() {
    std::string entrada;
    std::cout << "Escribe un valor (ej: 45d, 100111b, 1Ah): ";
    std::cin >> entrada;

    int decimal;
    char sufijo = std::tolower(entrada.back());
    std::string valorStr = entrada.substr(0, entrada.length() - 1);

    switch (sufijo) {
        case 'd':
            decimal = std::stoi(valorStr);
            break;
        case 'b':
            decimal = binarioADecimal(valorStr);
            break;
        case 'h':
            decimal = hexadecimalADecimal(valorStr);
            break;
        default:
            std::cout << "Sufijo inválido. Use d, b o h." << std::endl;
            return 1;
    }

    std::string binario = decimalABinario(decimal);
    std::string hexadecimal = decimalAHexadecimal(decimal);

    std::cout << "\nResultados:\n";
    std::cout << decimal << "d = " << binario << "b = " << hexadecimal << "h" << std::endl;

    return 0;
}
