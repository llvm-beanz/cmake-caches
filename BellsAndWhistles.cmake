set(LLVM_ENABLE_ASSERTIONS On CACHE BOOL "")
set(LLVM_TARGETS_TO_BUILD "X86;ARM;AArch64" CACHE STRING "")
set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")
set(CMAKE_INSTALL_PREFIX $ENV{PWD}/install CACHE STRING "")
set(LLVM_CREATE_XCODE_TOOLCHAIN On CACHE BOOL "")
set(LLVM_BUILD_EXTERNAL_COMPILER_RT On CACHE BOOL "")
set(CLANG_APPEND_VC_REV On CACHE BOOL "")
set(LLVM_BUILD_LLVM_DYLIB On CACHE BOOL "")
set(CLANG_ENABLE_BOOTSTRAP On CACHE BOOL "")

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

#set(LLVM_DISTRIBUTION_COMPONENTS
#  clang
#  LTO
#  clang-format
#  clang-tidy
#  clangd
#  clang-resource-headers
#  lld
#  builtins
#  ${LLVM_TOOLCHAIN_TOOLS}
#  CACHE STRING "")

#set(LLVM_RUNTIME_DISTRIBUTION_COMPONENTS
#  asan
#  ubsan
#  lsan
#  tsan
#  fuzzer
#  cxx-headers
#  CACHE STRING "")
#set(LLDB_CODESIGN_IDENTITY "Mac Developer" CACHE STRING "")

string(TOUPPER "${CMAKE_BUILD_TYPE}" uppercase_CMAKE_BUILD_TYPE)

find_program(SCCACHE sccache HINTS /usr/local/bin)
if (SCCACHE)
  set(CMAKE_C_COMPILER_LAUNCHER ${SCCACHE} CACHE STRING "")
  set(CMAKE_CXX_COMPILER_LAUNCHER ${SCCACHE} CACHE STRING "")
endif()

if(uppercase_CMAKE_BUILD_TYPE STREQUAL "DEBUG")
  set(LLVM_OPTIMIZED_TABLEGEN On CACHE BOOL "")
  set(LLVM_USE_SANITIZER "Address;Undefined" CACHE STRING "")
endif()
if (CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address,undefined -fno-sanitize=vptr,function -fno-sanitize-recover=all")
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address,undefined -fno-sanitize=vptr,function -fno-sanitize-recover=all")
  set(LLVM_OPTIMIZED_TABLEGEN On CACHE BOOL "")
endif()

if(NOT $ENV{TOOLCHAINS} STREQUAL "")
  message("Querying for compilers from $ENV{TOOLCHAINS}...")
  execute_process(COMMAND xcrun -toolchain $ENV{TOOLCHAINS} -find clang
   OUTPUT_VARIABLE CMAKE_C_COMPILER
   ERROR_QUIET
   OUTPUT_STRIP_TRAILING_WHITESPACE)

  execute_process(COMMAND xcrun -toolchain $ENV{TOOLCHAINS} -find clang++
   OUTPUT_VARIABLE CMAKE_CXX_COMPILER
   ERROR_QUIET
   OUTPUT_STRIP_TRAILING_WHITESPACE)

  set(CMAKE_C_COMPILER ${CMAKE_C_COMPILER} CACHE STRING "")
  set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER} CACHE STRING "")
  set(CMAKE_CXX_COMPILER ${CMAKE_CXX_COMPILER} CACHE STRING "")
endif()

set(LLDB_TEST_CLANG ON CACHE BOOL "")
set(SWIFT_BUILD_PERF_TESTSUITE OFF CACHE BOOL "")
