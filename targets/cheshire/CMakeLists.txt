# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Moritz Scherer <scheremo@iis.ee.ethz.ch>
# Viviane Potocnik <vivianep@iis.ee.ethz.ch>

set(TARGET "Cheshire")
set(CROSS_C_COMPILER "clang")
set(CROSS_AR "llvm-ar")
set(CROSS_STRIP "llvm-strip")
set(TARGET_FLAG "riscv32-unknown-elf")

set(CROSS_CPU "riscv32")
set(CROSS_CPU_FAMILY "riscv32")
set(CROSS_ENDIAN "little")
set(CROSS_SYSTEM "none")

set(ISA rv32imc)
set(ABI ilp32)

set(CROSS_C_COMPILER_ARGS "-target ${TARGET_FLAG} -march=${ISA} -nostdlib")
set(CROSS_C_ARGS "-Werror=double-promotion -Wno-unsupported-floating-point-opt -fshort-enums -mno-relax -march=${ISA} -mabi=${ABI}")
set(CROSS_C_LINK_ARGS "-Wl,-z,noexecstack -march=${ISA} -mabi=${ABI}")

set(CROSS_SKIP_SANITY_CHECK "true")

include(${CMAKE_CURRENT_LIST_DIR}/../../cmake/picolibc.cmake)


file(GLOB_RECURSE ASM_SOURCES
  "src/crt0.S"
)
set_property(SOURCE ${ASM_SOURCES} PROPERTY LANGUAGE ASM)
add_library(runtime OBJECT ${ASM_SOURCES})


target_compile_options(runtime
  PUBLIC
  -march=${ISA}
  -mabi=${ABI}
)

target_compile_definitions(runtime
    PUBLIC
    OT_PLATFORM_RV32
)

target_link_options(runtime
  PUBLIC
  -march=${ISA}
  -mabi=${ABI}
  -nostartfiles
  -nostdlib
  -L${CMAKE_CURRENT_LIST_DIR}
  -Tlink.ld
)
