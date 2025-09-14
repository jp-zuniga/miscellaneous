#include <cmath>
#include <iostream>
#include <string>

std::string decimalToBinary(int decimal) {
  if (decimal == 0) {
    return "0";
  }

  std::string binary = "";

  while (decimal > 0) {
    binary = std::to_string(decimal % 2) + binary;
    decimal /= 2;
  }

  return binary;
}

std::string decimalToHexadecimal(int decimal) {
  if (decimal == 0) {
    return "0";
  }

  char hexChars[] = "0123456789ABCDEF";
  std::string hexadecimal = "";

  while (decimal > 0) {
    hexadecimal = hexChars[decimal % 16] + hexadecimal;
    decimal /= 16;
  }

  return hexadecimal;
}

int binaryToDecimal(std::string binary) {
  int power = 0;
  int decimal = 0;

  for (int i = binary.length() - 1; i >= 0; i--) {
    if (binary[i] == '1') {
      decimal += std::pow(2, power);
    }

    power++;
  }

  return decimal;
}

int hexadecimalToDecimal(std::string hexadecimal) {
  int decimal = 0;
  int power = 0;

  for (int i = hexadecimal.length() - 1; i >= 0; i--) {
    int value;
    char c = std::toupper(hexadecimal[i]);

    if (c >= '0' && c <= '9') {
      value = c - '0';
    } else {
      value = c - 'A' + 10;
    }

    decimal += value * std::pow(16, power);
    power++;
  }

  return decimal;
}

int main() {
  std::string input;
  std::cout << "Escribe su valor (ej: 45d, 100111b, 1Ah): ";
  std::cin >> input;

  char suffix = std::tolower(input.back());
  std::string valueStr = input.substr(0, input.length() - 1);
  int decimal;

  switch (suffix) {
  case 'd':
    decimal = std::stoi(valueStr);
    break;
  case 'b':
    decimal = binaryToDecimal(valueStr);
    break;
  case 'h':
    decimal = hexadecimalToDecimal(valueStr);
    break;
  default:
    std::cout << "Sufijo inválido. Use d, b o h." << std::endl;
    return 1;
  }

  std::string binary = decimalToBinary(decimal);
  std::string hexadecimal = decimalToHexadecimal(decimal);

  std::cout << "\nResultados:\n";
  std::cout << decimal << "d = " << binary << "b = " << hexadecimal << "h"
            << std::endl;

  return 0;
}
