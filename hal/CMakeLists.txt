# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Moritz Scherer <scheremo@iis.ee.ethz.ch>

file(GLOB_RECURSE SOURCES
  "src/*"
)

add_library(hal STATIC ${SOURCES})

target_include_directories(hal
  PUBLIC
  "inc/"
)
