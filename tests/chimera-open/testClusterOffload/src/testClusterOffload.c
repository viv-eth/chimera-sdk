// Copyright 2024 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Moritz Scherer <scheremo@iis.ee.ethz.ch>

#include "soc_ctrl.h"
#include "soc_addr_map.h"
#include <regs/soc_ctrl.h>

#define TESTVAL 0x050CCE55

static uint32_t *clintPointer = (uint32_t *)CLINT_CTRL_BASE;

void clusterInterruptHandler() {
    uint8_t hartId;
    asm("csrr %0, mhartid" : "=r"(hartId)::);

    volatile uint32_t *interruptTarget = clintPointer + hartId;
    *interruptTarget = 0;
    return;
}

int32_t testReturn() {
    return TESTVAL;
}

int main() {
    setupInterruptHandler(clusterInterruptHandler);
    offloadToCluster(testReturn, 0);
    uint32_t retVal = waitForCluster(0);

    return (retVal != (TESTVAL | 0x000000001));
}
