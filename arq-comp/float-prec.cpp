#include <iostream>

int main() {
    std::cout.precision(20);

    // Case 1:
    float x = 0.2;
    double y = 0.2;

    std::cout << "x = " << x << "\n";
    std::cout << "y = " << y << "\n\n";

    // Case 2:
    float a = 100000000;
    float b = 0.5;
    float c = a + b;

    std::cout << "a = " << a << "\n";
    std::cout << "b = " << b << "\n";
    std::cout << "a + b = " << c << "\n\n";

    // Case 3:
    double f = (0.3 * 3) + 0.1;
    double g = 1.0;

    std::cout << "f = " << f << "\n";
    std::cout << "g = " << g << "\n";
    std::cout << "f == g: " << (f == g ? "True" : "False") << std::endl;

    return 0;
}
