# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Viviane Potocnik <vivianep@iis.ee.ethz.ch>

message(STATUS "Configuring drivers...")

add_library(drivers INTERFACE)

# Link to the opentitan library
target_link_libraries(drivers
    INTERFACE
    opentitan_lib
)