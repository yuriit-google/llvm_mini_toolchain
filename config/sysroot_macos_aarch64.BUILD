# MIT License
#
# Copyright (c) 2024 Google LLC
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

load(
    "@llvm_mini_toolchain//features:cc_toolchain_import.bzl",
    "cc_toolchain_import",
)
load(
    "@llvm_mini_toolchain//cc_toolchain:sysroot.bzl",
    "sysroot_package",
)

sysroot_package(
    name = "sysroot",
    visibility = ["//visibility:public"],
)

CRT_OBJECTS = [
    # "crt1", # error: ld64.lld: warning: usr/lib/crt1.o has architecture x86_64 which is incompatible with target architecture arm64
]

[
    cc_toolchain_import(
        name = obj,
        static_library = "usr/lib/%s.o" % obj,
    )
    for obj in CRT_OBJECTS
]

cc_toolchain_import(
    name = "startup_libs",
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
    visibility = ["//visibility:public"],
    deps = [":" + obj for obj in CRT_OBJECTS],
)

cc_toolchain_import(
    name = "includes_c",
    hdrs = glob([
        "usr/include/c++/v1/**",
    ]),
    includes = [
        "usr/include/c++/v1",
    ],
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
    visibility = ["//visibility:public"],
)

cc_toolchain_import(
    name = "includes_system",
    hdrs = glob([
        "usr/include/**",
        "System/Library/Frameworks/CoreFoundation/**",                      # Include created symbolic link directory
        "System/Library/Frameworks/CoreFoundation.framework/**",
    ]),
    includes = [
        "usr/include",
        "System/Library/Frameworks",
    ],
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
    visibility = ["//visibility:public"],
)

# In Darwin, much is built into the system library, /usr/lib/libSystem.tbd.
# In particular, the following libraries are included in libSystem:
#   * libinfo - NetInfo library
#   * libm - math library, which contains arithmetic functions
#   * libpthread - POSIX threads library, which allows multiple tasks to run concurrently
cc_toolchain_import(
    name = "system",
    shared_library = "usr/lib/libSystem.tbd",
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
    visibility = ["//visibility:public"],
)

cc_toolchain_import(
    name = "libm",
    shared_library = "usr/lib/libm.tbd",
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
    visibility = ["//visibility:public"],
)

cc_toolchain_import(
    name = "stdc++",
    shared_library = "usr/lib/libc++.tbd",
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
    visibility = ["//visibility:public"],
)

# Redundancy library (for configuration compatibility with Linux system)
cc_toolchain_import(
    name = "pthread",
    shared_library = "usr/lib/libpthread.tbd",
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
    visibility = ["//visibility:public"],
    deps = [
        ":glibc",
    ],
)

cc_toolchain_import(
    name = "util",
    shared_library = "usr/lib/libutil.tbd",
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
)

cc_toolchain_import(
    name = "objc",
    shared_library = "usr/lib/libobjc.tbd",
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
)

cc_toolchain_import(
    name = "core_foundation",
    additional_libs = [
        "usr/lib/libobjc.A.tbd",
        "usr/lib/libobjc.tbd",
    ],
    shared_library = "System/Library/Frameworks/CoreFoundation.framework/CoreFoundation.tbd",
)

# This is a group of all the system libraries we need. The actual glibc library is split
# out to fix link ordering problems that cause false undefined symbol positives.
cc_toolchain_import(
    name = "glibc",
    #runtime_path = "usr/lib",
    #target_compatible_with = select({
    #    "@platforms//os:macos": ["@platforms//cpu:aarch64"],
    #    "//conditions:default": ["@platforms//:incompatible"],
    #}),
    visibility = ["//visibility:public"],
    deps = [
        ":system",
        ":libm",
        ":util",
        ":stdc++",
        ":objc",
        ":core_foundation",
    ],
)
