load(
    "@llvm_mini_toolchain//cc_toolchain:cc_toolchain_import.bzl",
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

cc_toolchain_import(
    name = "includes",
    hdrs = glob([
        "/usr/lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/**",
        "/usr/lib/gcc/x86_64-linux-gnu/14/../../../../include/x86_64-linux-gnu/c++/14/**",
        "/usr/lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/backward/**",
        "/usr/local/google/home/yuriit/Downloads/LLVM-19.1.3-Linux-X64/lib/clang/19/include/**",
        "/usr/local/include/**",
        "/usr/include/x86_64-linux-gnu/**",
        "/usr/include/**",
    ]),
    includes = [
        "/usr/lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14",
        "/usr/lib/gcc/x86_64-linux-gnu/14/../../../../include/x86_64-linux-gnu/c++/14",
        "/usr/lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/backward",
        "/usr/local/google/home/yuriit/Downloads/LLVM-19.1.3-Linux-X64/lib/clang/19/include",
        "/usr/local/include",
        "/usr/include/x86_64-linux-gnu",
        "/usr/include",
    ],
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

cc_toolchain_import(
    name = "gcc",
    additional_libs = [
        "lib/x86_64-linux-gnu/libgcc_s.so.1",
        "usr/lib/gcc/x86_64-linux-gnu/{gcc_version}/libgcc_eh.a".format(gcc_version = GCC_VERSION),
    ],
    runtime_path = "/usr/lib/x86_64-linux-gnu",
    shared_library = "usr/lib/gcc/x86_64-linux-gnu/{gcc_version}/libgcc_s.so".format(gcc_version = GCC_VERSION),
    static_library = "usr/lib/gcc/x86_64-linux-gnu/{gcc_version}/libgcc.a".format(gcc_version = GCC_VERSION),
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

cc_toolchain_import(
    name = "stdc++",
    additional_libs = [
        "usr/lib/x86_64-linux-gnu/libstdc++.so.6",
        "usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25",
    ],
    shared_library = "usr/lib/gcc/x86_64-linux-gnu/{gcc_version}/libstdc++.so".format(gcc_version = GCC_VERSION),
    static_library = "usr/lib/gcc/x86_64-linux-gnu/{gcc_version}/libstdc++.a".format(gcc_version = GCC_VERSION),
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

cc_toolchain_import(
    name = "mvec",
    additional_libs = [
        "lib/x86_64-linux-gnu/libmvec-{glibc_version}.so".format(glibc_version = GLIBC_VERSION),
        "lib/x86_64-linux-gnu/libmvec.so.1",
        "usr/lib/x86_64-linux-gnu/libmvec_nonshared.a",
    ],
    shared_library = "usr/lib/x86_64-linux-gnu/libmvec.so",
    static_library = "usr/lib/x86_64-linux-gnu/libmvec.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
)

cc_toolchain_import(
    name = "dynamic_linker",
    additional_libs = [
        "lib64/ld-linux-x86-64.so.2",
        "lib/x86_64-linux-gnu/ld-linux-x86-64.so.2",
    ],
    runtime_path = "/lib64",
    shared_library = "usr/lib/x86_64-linux-gnu/libdl.so",
    static_library = "usr/lib/x86_64-linux-gnu/libdl.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    deps = [":libc"],
)

cc_toolchain_import(
    name = "math",
    additional_libs = ["lib/x86_64-linux-gnu/libm.so.6"],
    shared_library = "usr/lib/x86_64-linux-gnu/libm.so",
    static_library = "usr/lib/x86_64-linux-gnu/libm.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

cc_toolchain_import(
    name = "pthread",
    additional_libs = [
        "lib/x86_64-linux-gnu/libpthread.so.0",
        "lib/x86_64-linux-gnu/libpthread-{glibc_version}.so".format(glibc_version = GLIBC_VERSION),
        "usr/lib/x86_64-linux-gnu/libpthread_nonshared.a",
    ],
    shared_library = "usr/lib/x86_64-linux-gnu/libpthread.so",
    static_library = "usr/lib/x86_64-linux-gnu/libpthread.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        ":libc",
    ],
)

cc_toolchain_import(
    name = "util",
    additional_libs = [
        "lib/x86_64-linux-gnu/libutil-{glibc_version}.so".format(glibc_version = GLIBC_VERSION),
        "lib/x86_64-linux-gnu/libutil.so.1",
    ],
    shared_library = "usr/lib/x86_64-linux-gnu/libutil.so",
    static_library = "usr/lib/x86_64-linux-gnu/libutil.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
)

cc_toolchain_import(
    name = "libc",
    additional_libs = [
        "lib/x86_64-linux-gnu/libc.so.6",
        "lib/x86_64-linux-gnu/libc-{glibc_version}.so".format(glibc_version = GLIBC_VERSION),
        "usr/lib/x86_64-linux-gnu/libc_nonshared.a",
    ],
    runtime_path = "/usr/lib/gcc/x86_64-linux-gnu/{gcc_version}".format(gcc_version = GCC_VERSION),
    shared_library = "usr/lib/x86_64-linux-gnu/libc.so",
    static_library = "usr/lib/x86_64-linux-gnu/libc.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        ":includes",
        ":gcc",
        ":math",
        ":mvec",
        ":util",
        ":stdc++",
    ],
)

# This is a group of all the system libraries we need. The actual glibc library is split
# out to fix link ordering problems that cause false undefined symbol positives.
cc_toolchain_import(
    name = "glibc",
    runtime_path = "/lib/x86_64-linux-gnu",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        ":dynamic_linker",
        ":libc",
    ],
)
