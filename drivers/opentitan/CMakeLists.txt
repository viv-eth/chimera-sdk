# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Viviane Potocnik <vivianep@iis.ee.ethz.ch>

message(STATUS "Configuring OpenTitan library...")

# Add OpenTitan sources
file(GLOB_RECURSE SOURCES
    "${CMAKE_CURRENT_SOURCE_DIR}/hw/top_earlgrey/sw/autogen/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/sw/device/lib/base/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/sw/device/lib/base/*.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/sw/device/lib/dif/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/sw/device/lib/dif/*.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/sw/device/lib/dif/autogen/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/sw/device/lib/dif/autogen/*.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/sw/device/lib/runtime/*.c"

)

# Exclude files
list(FILTER SOURCES EXCLUDE REGEX ".*crc32.*")
list(FILTER SOURCES EXCLUDE REGEX ".*hardened.*")


add_library(opentitan_lib STATIC ${SOURCES})

target_include_directories(opentitan_lib
    PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_link_libraries(opentitan_lib
    PUBLIC
    runtime
)