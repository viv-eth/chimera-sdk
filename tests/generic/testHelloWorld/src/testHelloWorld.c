// Copyright 2024 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Viviane Potocnik <vivianep@iis.ee.ethz.ch>

#include <stdio.h>
#include <string.h>

#include "device_api.h"
#include "uart.h"

int main() {

    struct chi_device device;

    int ret;
    
    ret = uart_open(&device);

    // if (ret != 0) {
    //     return -1;
    // }

    // ret = uart_close(&device);

    // if (ret != 0) {
    //     return -1;
    // }

    return 0;
}