load(
    "@llvm_mini_toolchain//features:feature_import.bzl",
    "feature_import",
)
load(
    "@llvm_mini_toolchain//cc_toolchain:sysroot.bzl",
    "sysroot_package",
)

print("================================ sysroot_linux_aarch64_glibc2_27.BUILD ========================================")

sysroot_package(
    name = "sysroot",
    visibility = ["//visibility:public"],
)

GCC_VERSION = 7
GLIBC_VERSION = "2.27"

CRT_OBJECTS = [
    "crti",
    "crtn",
    # Use PIC Scrt1.o instead of crt1.o to keep PIC code from segfaulting.
    "Scrt1",
]

[
    feature_import(
        name = obj,
        static_library = "usr/lib/aarch64-linux-gnu/%s.o" % obj,
    )
    for obj in CRT_OBJECTS
]

feature_import(
    name = "startup_libs",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [":" + obj for obj in CRT_OBJECTS],
)

feature_import(
    name = "includes",
    hdrs = glob([
        "usr/include/c++/*/**",
        "usr/include/aarch64-linux-gnu/c++/*/**",
        "usr/lib/gcc/aarch64-linux-gnu/7/include/**",
        "usr/local/include/**",
        "usr/include/aarch64-linux-gnu/**",
        "usr/include/**",
    ]),
    includes = [
        "usr/include/c++/7",
        "usr/include/aarch64-linux-gnu/c++/7",
        "usr/include/c++/7/backward",
        "usr/lib/gcc/aarch64-linux-gnu/7/include",
        "usr/local/include",
        "usr/include/aarch64-linux-gnu",
        "usr/include",
    ],
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

feature_import(
    name = "gcc",
    additional_libs = [
        "lib/aarch64-linux-gnu/libgcc_s.so.1",
        "usr/lib/gcc/aarch64-linux-gnu/{gcc_version}/libgcc_eh.a".format(gcc_version = GCC_VERSION),
    ],
    runtime_path = "/usr/lib/aarch64-linux-gnu",
    shared_library = "usr/lib/gcc/aarch64-linux-gnu/{gcc_version}/libgcc_s.so".format(gcc_version = GCC_VERSION),
    static_library = "usr/lib/gcc/aarch64-linux-gnu/{gcc_version}/libgcc.a".format(gcc_version = GCC_VERSION),
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

# absent
#feature_import(
#    name = "mvec",
#    additional_libs = [
#        "lib/aarch64-linux-gnu/libmvec-{glibc_version}.so".format(glibc_version = GLIBC_VERSION),
#        "lib/aarch64-linux-gnu/libmvec.so.1",
#        "usr/lib/aarch64-linux-gnu/libmvec_nonshared.a",
#    ],
#    shared_library = "usr/lib/aarch64-linux-gnu/libmvec.so",
#    static_library = "usr/lib/aarch64-linux-gnu/libmvec.a",
#    target_compatible_with = select({
#        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
#        "//conditions:default": ["@platforms//:incompatible"],
#    }),
#)

feature_import(
    name = "dynamic_linker",
    additional_libs = [
        "lib/aarch64-linux-gnu/ld-linux-aarch64.so.1",
    ],
    runtime_path = "/lib64",
    shared_library = "usr/lib/aarch64-linux-gnu/libdl.so",
    static_library = "usr/lib/aarch64-linux-gnu/libdl.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    deps = [":libc"],
)

feature_import(
    name = "math",
    additional_libs = ["lib/aarch64-linux-gnu/libm.so.6"],
    shared_library = "usr/lib/aarch64-linux-gnu/libm.so",
    static_library = "usr/lib/aarch64-linux-gnu/libm.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
)

feature_import(
    name = "pthread",
    additional_libs = [
        "lib/aarch64-linux-gnu/libpthread.so.0",
        "lib/aarch64-linux-gnu/libpthread-{glibc_version}.so".format(glibc_version = GLIBC_VERSION),
        "usr/lib/aarch64-linux-gnu/libpthread_nonshared.a",
    ],
    shared_library = "usr/lib/aarch64-linux-gnu/libpthread.so",
    static_library = "usr/lib/aarch64-linux-gnu/libpthread.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        ":libc",
    ],
)

feature_import(
    name = "util",
    shared_library = "usr/lib/aarch64-linux-gnu/libutil.so",
    static_library = "usr/lib/aarch64-linux-gnu/libutil.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
)

feature_import(
    name = "libc",
    additional_libs = [
        "lib/aarch64-linux-gnu/libc.so.6",
        "usr/lib/aarch64-linux-gnu/libc_nonshared.a",
    ],
    runtime_path = "/usr/lib/gcc/aarch64-linux-gnu/{gcc_version}".format(gcc_version = GCC_VERSION),
    shared_library = "usr/lib/aarch64-linux-gnu/libc.so",
    static_library = "usr/lib/aarch64-linux-gnu/libc.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        ":includes",
        ":gcc",
        ":math",
        #":mvec",
        ":util",
    ],
)

# This is a group of all the system libraries we need. The actual glibc library is split
# out to fix link ordering problems that cause false undefined symbol positives.
feature_import(
    name = "glibc",
    runtime_path = "/lib/aarch64-linux-gnu",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:aarch64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        ":dynamic_linker",
        ":libc",
    ],
)
