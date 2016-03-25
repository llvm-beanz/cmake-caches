set(LLVM_ENABLE_ASSERTIONS On CACHE BOOL "")
set(LLVM_TARGETS_TO_BUILD "X86;ARM;AArch64" CACHE STRING "")
set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")
set(CMAKE_INSTALL_PREFIX $ENV{PWD}/install CACHE STRING "")
set(LLVM_CREATE_XCODE_TOOLCHAIN On CACHE BOOL "")
set(LLVM_BUILD_EXTERNAL_COMPILER_RT On CACHE BOOL "")
set(CLANG_APPEND_VC_REV On CACHE BOOL "")
set(LLVM_BUILD_LLVM_DYLIB On CACHE BOOL "")
set(CLANG_ENABLE_BOOTSTRAP On CACHE BOOL "")
set(LLVM_DISTRIBUTION_COMPONENTS "clang;compiler-rt;LTO" CACHE STRING "")
set(COMPILER_RT_ENABLE_IOS On CACHE BOOL "") 
