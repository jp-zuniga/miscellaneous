// convertir de resistancias a temperatura

#include <iostream>
#include <cmath>
#include <vector>


double ntc_resistance_to_temp(double R) {
    const double R0 = 1000.0;  // resistencia nominal
    const double T0 = 298.15;  // temperatura nominal (en kelvin)
    const double B  = 3730.0;  // constante beta

    double T = 1.0 / ((1.0 / T0) + ((1.0 / B) * log(R / R0)));
    double T_Celsius = T - 273.15;

    return T_Celsius;
}


int main() {
    std::vector<double> temperaturas = {
    -55, -50, -45, -40, -35, -30, -25, -20, -15, -10,
    -5, 0, 5, 10, 15, 20, 25, 30, 35, 40,
    45, 50, 55, 60, 65, 70, 75, 80, 85, 90
};

    std::vector<double> resistencias = {
        70014, 49906, 36015, 26296,
        19411, 14479, 10903, 8292,
        6350, 4920, 3828, 3003,
        2377, 1896, 1521, 1228,
        1000.0, 817.8, 673.4, 557.5,
        463.6, 387.4, 325.0, 272.0,
        228.3, 192.0, 161.6, 136.0,
        123.5, 106.7
    };

    for (size_t i = 0; i < resistencias.size(); i++) {
        double calculado = ntc_resistance_to_temp(resistencias[i]);
        std::cout << resistencias[i]
                  << " - " << calculado << " - "
                  << std::abs(temperaturas[i] - calculado)
                  << std::endl;
    }

    return 0;
}
