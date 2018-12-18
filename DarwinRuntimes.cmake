set(LLVM_ENABLE_PER_TARGET_RUNTIME_DIR On CACHE BOOL "")

function(find_darwin_sdk_dir var sdk_name)
  set(DARWIN_${sdk_name}_CACHED_SYSROOT "" CACHE STRING "Darwin SDK path for SDK ${sdk_name}.")
  set(DARWIN_PREFER_PUBLIC_SDK OFF CACHE BOOL "Prefer Darwin public SDK, even when an internal SDK is present.")

  if(DARWIN_${sdk_name}_CACHED_SYSROOT)
    set(${var} ${DARWIN_${sdk_name}_CACHED_SYSROOT} PARENT_SCOPE)
    return()
  endif()
  if(NOT DARWIN_PREFER_PUBLIC_SDK)
    # Let's first try the internal SDK, otherwise use the public SDK.
    execute_process(
      COMMAND xcodebuild -version -sdk ${sdk_name}.internal Path
      RESULT_VARIABLE result_process
      OUTPUT_VARIABLE var_internal
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_FILE /dev/null
    )
  endif()
  if((NOT result_process EQUAL 0) OR "" STREQUAL "${var_internal}")
    execute_process(
      COMMAND xcodebuild -version -sdk ${sdk_name} Path
      RESULT_VARIABLE result_process
      OUTPUT_VARIABLE var_internal
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_FILE /dev/null
    )
  else()
    set(${var}_INTERNAL ${var_internal} PARENT_SCOPE)
  endif()
  if(result_process EQUAL 0)
    set(${var} ${var_internal} PARENT_SCOPE)
  endif()
  set(DARWIN_${sdk_name}_CACHED_SYSROOT ${var_internal} CACHE STRING "Darwin SDK path for SDK ${sdk_name}." FORCE)
endfunction()

set(LLVM_BUILTIN_TARGETS x86_64-apple-macosx10.9.0
                         arm64-apple-ios9.0.0 CACHE STRING "")
set(LLVM_RUNTIME_TARGETS "${LLVM_BUILTIN_TARGETS}" CACHE STRING "")

find_darwin_sdk_dir(DARWIN_x86_64-apple-macosx10.9.0_SYSROOT macosx)
find_darwin_sdk_dir(DARWIN_arm64-apple-ios9.0.0_SYSROOT iphoneos)

# Set the per-target builtins options.
foreach(target ${LLVM_BUILTIN_TARGETS})
  set(BUILTINS_${target}_CMAKE_SYSTEM_NAME Darwin CACHE STRING "")
  set(BUILTINS_${target}_CMAKE_SYSTEM_VERSION 13 CACHE STRING "")
  set(BUILTINS_${target}_CMAKE_BUILD_TYPE Release CACHE STRING "")
  set(BUILTINS_${target}_CMAKE_OSX_SYSROOT ${DARWIN_${target}_SYSROOT} CACHE PATH "")
  set(BUILTINS_${target}_CMAKE_BUILD_TYPE Release CACHE STRING "")

  set(RUNTIMES_${target}_CMAKE_SYSTEM_NAME Darwin CACHE STRING "")
  set(BUILTINS_${target}_CMAKE_SYSTEM_VERSION 13 CACHE STRING "")
  set(RUNTIMES_${target}_CMAKE_BUILD_TYPE Release CACHE STRING "")
  set(RUNTIMES_${target}_CMAKE_OSX_SYSROOT ${DARWIN_${target}_SYSROOT} CACHE PATH "")
  set(RUNTIMES_${target}_CMAKE_BUILD_TYPE Release CACHE STRING "")
endforeach()
