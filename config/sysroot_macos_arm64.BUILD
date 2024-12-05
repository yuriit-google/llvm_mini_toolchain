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
    "crt1",
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
    target_compatible_with = select({
        "@platforms//os:macos": ["@platforms//cpu:arm64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [":" + obj for obj in CRT_OBJECTS],
)

cc_toolchain_import(
    name = "includes",
    hdrs = glob([
        "usr/include/c++/v1/**",
        "usr/include/**",
        "System/Library/Frameworks/**",
    ]),
    includes = [
        "usr/include/c++/v1",
        "usr/include",
        "System/Library/Frameworks",
    ],
    target_compatible_with = select({
        "@platforms//os:macos": ["@platforms//cpu:arm64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

# usr/lib/libc++.tbd
# usr/lib/libc++abi.tbd
cc_toolchain_import(
    name = "stdc++",
    shared_library = "usr/lib/libc++.tbd",
    target_compatible_with = select({
        "@platforms//os:macos": ["@platforms//cpu:arm64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

# Path to vecLib.tbd
# ./System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/vecLib.tbd
#cc_toolchain_import(
#    name = "mvec",
#    additional_libs = [
#        "lib/x86_64-linux-gnu/libmvec-{glibc_version}.so".format(glibc_version = GLIBC_VERSION),
#        "lib/x86_64-linux-gnu/libmvec.so.1",
#        "usr/lib/x86_64-linux-gnu/libmvec_nonshared.a",
#    ],
#    shared_library = "usr/lib/x86_64-linux-gnu/libmvec.so",
#    static_library = "usr/lib/x86_64-linux-gnu/libmvec.a",
#    target_compatible_with = select({
#        "@platforms//os:macos": ["@platforms//cpu:arm64"],
#        "//conditions:default": ["@platforms//:incompatible"],
#    }),
#)

#cc_toolchain_import(
#    name = "dynamic_linker",
#    additional_libs = [
#        "lib64/ld-linux-x86-64.so.2",
#        "lib/x86_64-linux-gnu/ld-linux-x86-64.so.2",
#    ],
#    runtime_path = "/lib64",
#    shared_library = "usr/lib/x86_64-linux-gnu/libdl.so",
#    static_library = "usr/lib/x86_64-linux-gnu/libdl.a",
#    target_compatible_with = select({
#        "@platforms//os:macos": ["@platforms//cpu:arm64"],
#        "//conditions:default": ["@platforms//:incompatible"],
#    }),
#    deps = [":libc"],
#)

cc_toolchain_import(
    name = "math",
    shared_library = "usr/lib/libm.tbd",
    target_compatible_with = select({
        "@platforms//os:macos": ["@platforms//cpu:arm64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

cc_toolchain_import(
    name = "pthread",
    shared_library = "usr/lib/libpthread.tbd",
    target_compatible_with = select({
        "@platforms//os:macos": ["@platforms//cpu:arm64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        ":libc",
    ],
)

cc_toolchain_import(
    name = "util",
    shared_library = "usr/lib/libutil.tbd",
    target_compatible_with = select({
        "@platforms//os:macos": ["@platforms//cpu:arm64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
)

# This is a group of all the system libraries we need. The actual glibc library is split
# out to fix link ordering problems that cause false undefined symbol positives.
cc_toolchain_import(
    name = "glibc",
    #runtime_path = "/lib/x86_64-linux-gnu",
    target_compatible_with = select({
        "@platforms//os:macos": ["@platforms//cpu:arm64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        #":dynamic_linker",
        ":includes",
        ":math",
        ":util",
        ":stdc++",
    ],
)
