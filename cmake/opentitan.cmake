# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Viviane Potocnik <vivianep@iis.ee.ethz.ch>

include(FetchContent)

# Fetch OpenTitan from GitHub
FetchContent_Declare(
  opentitan
  GIT_REPOSITORY https://github.com/lowRISC/opentitan.git
  GIT_TAG master # Replace with the desired tag
)

message(STATUS "Fetching OpenTitan from GitHub...")

# FetchContent_MakeAvailable(opentitan)

# # Add only relevant OpenTitan libraries
# set(OPENTITAN_BASE_DIR ${opentitan_SOURCE_DIR}/sw/device/lib/base)
# set(OPENTITAN_DIF_DIR ${opentitan_SOURCE_DIR}/sw/device/lib/dif)
# set(OPENTITAN_RUNTIME_DIR ${opentitan_SOURCE_DIR}/sw/device/lib/runtime)
# set(OPENTITAN_AUTOGEN_DIR ${opentitan_SOURCE_DIR}/hw/top_earlgrey/sw/autogen)

# message(STATUS "Copying OpenTitan libraries to drivers...")
# # Copy files to drivers
# file(COPY ${OPENTITAN_BASE_DIR} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/)
# file(COPY ${OPENTITAN_DIF_DIR} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/)
# file(COPY ${OPENTITAN_RUNTIME_DIR} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/)
# file(COPY ${OPENTITAN_AUTOGEN_DIR} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/hw/top_earlgrey/sw/)