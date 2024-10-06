# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Viviane Potocnik <vivianep@iis.ee.ethz.ch>

include(FetchContent)

# Fetch OpenTitan from GitHub
FetchContent_Declare(
  opentitan
  # GIT_REPOSITORY https://github.com/lowRISC/opentitan.git
  GIT_REPOSITORY https://github.com/viv-eth/opentitan-devel.git
  GIT_TAG vivianep/chimera # Replace with the desired tag
)

message(STATUS "Fetching OpenTitan from GitHub...")

FetchContent_MakeAvailable(opentitan)

# Add only relevant OpenTitan libraries
set(OPENTITAN_UTIL_DIR ${opentitan_SOURCE_DIR}/util)
set(OPENTITAN_HW_IP_DIR ${opentitan_SOURCE_DIR}/hw/ip)
set(OPENTITAN_BASE_DIR ${opentitan_SOURCE_DIR}/sw/device/lib/base)
set(OPENTITAN_BASE_INTERNAL_DIR ${opentitan_SOURCE_DIR}/sw/device/lib/base/internal)
set(OPENTITAN_DIF_DIR ${opentitan_SOURCE_DIR}/sw/device/lib/dif)
set(OPENTITAN_DIF_AUTOGEN_DIR ${opentitan_SOURCE_DIR}/sw/device/lib/dif/autogen)

set(OPENTITAN_PY_REQS
  ${OPENTITAN_UTIL_DIR}/../python-requirements.txt
)

set(OPENTITAN_HW_IP_UART
  ${OPENTITAN_HW_IP_DIR}/uart/data/uart.hjson
)

set(REGTOOLPY
${OPENTITAN_UTIL_DIR}/regtool.py
)

add_custom_command(
  OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/dif/autogen/uart_regs.h
  COMMAND ${REGTOOLPY} ${OPENTITAN_HW_IP_UART} -D >${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/dif/uart_regs.h
  DEPENDS ${OPENTITAN_HW_IP_UART}
  COMMENT "Generating uart_regs.h"
)

add_custom_target(generate_uart_regs ALL
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/dif/autogen/uart_regs.h
)

# Define files for UART
set(UART_BASE_FILES
  ${OPENTITAN_BASE_DIR}/bitfield.c
  ${OPENTITAN_BASE_DIR}/bitfield.h
  ${OPENTITAN_BASE_DIR}/macros.h
  ${OPENTITAN_BASE_DIR}/math.c
  ${OPENTITAN_BASE_DIR}/math.h
  ${OPENTITAN_BASE_DIR}/memory.c
  ${OPENTITAN_BASE_DIR}/memory.h
  ${OPENTITAN_BASE_DIR}/mmio.c
  ${OPENTITAN_BASE_DIR}/mmio.h
  ${OPENTITAN_BASE_DIR}/multibits.h 
)

set(UART_BASE_INTERNAL_FILES
  ${OPENTITAN_BASE_INTERNAL_DIR}/absl_status.h
  ${OPENTITAN_BASE_INTERNAL_DIR}/status.h
)

set(UART_DIF_FILES
  ${OPENTITAN_DIF_DIR}/dif_uart.c
  ${OPENTITAN_DIF_DIR}/dif_uart.h
  ${OPENTITAN_DIF_DIR}/dif_base.c
  ${OPENTITAN_DIF_DIR}/dif_base.h 
)

set(UART_DIF_AUTOGEN_FILES
  ${OPENTITAN_DIF_AUTOGEN_DIR}/dif_uart_autogen.h
)

message(STATUS "Copying OpenTitan libraries to drivers...")
# Copy files to drivers
file(COPY ${OPENTITAN_PY_REQS} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/)
file(COPY ${UART_BASE_FILES} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/base/)
file(COPY ${UART_BASE_INTERNAL_FILES} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/base/internal/)
file(COPY ${UART_DIF_FILES} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/dif/)
file(COPY ${UART_DIF_AUTOGEN_FILES} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/drivers/opentitan/sw/device/lib/dif/autogen/)
