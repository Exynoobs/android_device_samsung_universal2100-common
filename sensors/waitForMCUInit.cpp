#include <fstream>
#include <chrono>
#include <thread>
#include "waitForMCUInit.h"

void mcuInitialize() {
    bool mcuInitialized = false;
    while (!mcuInitialized) {
        std::ifstream mcu("/sys/devices/virtual/sensors/ssp_sensor/mcu_test");
        std::string value;

        if (!mcu) {
            std::this_thread::sleep_for(std::chrono::milliseconds(100));
            continue;
        }

        if (mcu >> value) {
            size_t length = value.length();
            size_t suffixLength = 2;  // Length of "OK"

            if (length >= suffixLength) {
                mcuInitialized = value.substr(length - suffixLength) == "OK";
            }
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
}