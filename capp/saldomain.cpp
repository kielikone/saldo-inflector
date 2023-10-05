#include<iostream>
#include "saldo.h"
#include <string>

int main () {
    saldoInit();
    std::string s = std::string();
    std::cout << "---" << std::endl;
    std::getline(std::cin, s);
    int retval = 0;
    char** vals = c_infl(s.c_str(), &retval);
    if (vals == NULL) {
        std::cout << "C++ received null" << std::endl;
    }else{
        std::cout << "C++ received non-null" << std::endl;
        std::cout << "Ret qty: " << retval << std::endl;
        for (int i = 0; i < retval; i++) {
            std::cout << vals[i] << std::endl;
        }
        std::cout << "deallocating..." << std::endl;
        c_free_arr(vals, retval);
    }
    saldoExit();
    std::cout << "---" << std::endl;
}
