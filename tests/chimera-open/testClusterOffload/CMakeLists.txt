# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Moritz Scherer <scheremo@iis.ee.ethz.ch>

project(chimera-sdk-testClusterOffload LANGUAGES C ASM)

file(GLOB_RECURSE TEST_SRCS
  "src/testClusterOffload.c"
)

add_chimera_test(
  testClusterOffload
  ${TEST_SRCS}
)

target_link_libraries(testClusterOffload PUBLIC chimera-sdk)
