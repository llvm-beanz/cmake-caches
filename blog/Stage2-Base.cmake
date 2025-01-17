# This file sets up a CMakeCache for Apple-style stage2 bootstrap. It is
# specified by the stage1 build.

set(LLVM_ENABLE_PROJECTS "clang;clang-tools-extra;lld" CACHE STRING "")
set(LLVM_ENABLE_RUNTIMES "compiler-rt;libcxx;libcxxabi;libunwind" CACHE STRING "")

set(LLVM_TARGETS_TO_BUILD AArch64 CACHE STRING "")
set(LLVM_INCLUDE_EXAMPLES OFF CACHE BOOL "")
set(LLVM_INCLUDE_DOCS OFF CACHE BOOL "")
set(CLANG_TOOL_SCAN_BUILD_BUILD OFF CACHE BOOL "")
set(CLANG_TOOL_SCAN_VIEW_BUILD OFF CACHE BOOL "")
set(CLANG_LINKS_TO_CREATE clang++ cc c++ CACHE STRING "")
set(CMAKE_MACOSX_RPATH ON CACHE BOOL "")
set(LLVM_ENABLE_ZLIB ON CACHE BOOL "")
set(LLVM_ENABLE_BACKTRACES OFF CACHE BOOL "")
set(LLVM_ENABLE_MODULES OFF CACHE BOOL "")
set(LLVM_EXTERNALIZE_DEBUGINFO ON CACHE BOOL "")
set(CLANG_PLUGIN_SUPPORT OFF CACHE BOOL "")

set(COMPILER_RT_ENABLE_IOS ON CACHE BOOL "Build iOS Compiler-RT libraries")

set(LLVM_CREATE_XCODE_TOOLCHAIN ON CACHE BOOL "Generate targets to create and install an Xcode compatible toolchain")

# Make unit tests (if present) part of the ALL target
set(LLVM_BUILD_TESTS ON CACHE BOOL "")

set(CMAKE_C_FLAGS "-fno-stack-protector -fno-common -Wno-profile-instr-unprofiled" CACHE STRING "")
set(CMAKE_CXX_FLAGS "-fno-stack-protector -fno-common -Wno-profile-instr-unprofiled" CACHE STRING "")

set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")

set(LIBCXX_INSTALL_LIBRARY OFF CACHE BOOL "")
set(LIBCXX_INSTALL_HEADERS ON CACHE BOOL "")
set(LIBCXX_INCLUDE_TESTS OFF CACHE BOOL "")
set(LLVM_LTO_VERSION_OFFSET 3000 CACHE STRING "")

# Generating Xcode toolchains is useful for developers wanting to build and use
# clang without installing over existing tools.
set(LLVM_CREATE_XCODE_TOOLCHAIN ON CACHE BOOL "")

# setup toolchain
set(LLVM_INSTALL_TOOLCHAIN_ONLY ON CACHE BOOL "")
set(LLVM_TOOLCHAIN_TOOLS
  dsymutil
  llvm-cov
  llvm-dwarfdump
  llvm-profdata
  llvm-objdump
  llvm-nm
  llvm-size
  CACHE STRING "")

set(LLVM_DISTRIBUTION_COMPONENTS
  clang
  LTO
  clang-format
  clang-tidy
  clangd
  clang-resource-headers
  lld
  builtins
  ${LLVM_TOOLCHAIN_TOOLS}
  CACHE STRING "")

set(LLVM_RUNTIME_DISTRIBUTION_COMPONENTS
  asan
  ubsan
  lsan
  tsan
  cxx-headers
  CACHE STRING "")
