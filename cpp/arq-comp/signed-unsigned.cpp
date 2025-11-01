#include <iostream>

int main() {
  unsigned char x = 192;

  unsigned char *p1 = &x;
  signed char *p2 = (signed char *)&x;

  std::cout << "x = " << (int)x << "\n";
  std::cout << "p1 = " << (int)*p1 << "\n";
  std::cout << "p2 = " << (int)*p2 << "\n";
  std::cout << "char = " << x << std::endl;

  return 0;
}
