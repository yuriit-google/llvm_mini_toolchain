load(
    "@llvm_mini_toolchain//features:feature_import.bzl",
    "feature_import",
)
load(
    "@llvm_mini_toolchain//cc_toolchain:sysroot.bzl",
    "sysroot_package",
)

print("================================ sysroot_linux_x86_64_glibc2_27.BUILD ========================================")

sysroot_package(
    name = "sysroot",
    visibility = ["//visibility:public"],
)

GCC_VERSION = 7
GLIBC_VERSION = "2.27"

INCLUDES = [
    "usr/local/include",
    "usr/include/x86_64-linux-gnu",
    "usr/include",
]

CRT_OBJECTS = [
    "crti",
    "crtn",
    # Use PIC Scrt1.o instead of crt1.o to keep PIC code from segfaulting.
    "Scrt1",
]

[
    feature_import(
        name = obj,
        static_library = "usr/lib/x86_64-linux-gnu/%s.o" % obj,
    )
    for obj in CRT_OBJECTS
]

feature_import(
    name = "startup_libs",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [":" + obj for obj in CRT_OBJECTS],
)

feature_import(
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

feature_import(
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

feature_import(
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

feature_import(
    name = "math",
    additional_libs = ["lib/x86_64-linux-gnu/libm.so.6"],
    shared_library = "usr/lib/x86_64-linux-gnu/libm.so",
    static_library = "usr/lib/x86_64-linux-gnu/libm.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
)

feature_import(
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

feature_import(
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

feature_import(
    name = "libc",
    hdrs = glob([inc + "/**/*.h" for inc in INCLUDES] + [inc + "/*.h" for inc in INCLUDES]),
    additional_libs = [
        "lib/x86_64-linux-gnu/libc.so.6",
        "lib/x86_64-linux-gnu/libc-{glibc_version}.so".format(glibc_version = GLIBC_VERSION),
        "usr/lib/x86_64-linux-gnu/libc_nonshared.a",
    ],
    includes = INCLUDES,
    runtime_path = "/usr/lib/gcc/x86_64-linux-gnu/{gcc_version}".format(gcc_version = GCC_VERSION),
    shared_library = "usr/lib/x86_64-linux-gnu/libc.so",
    static_library = "usr/lib/x86_64-linux-gnu/libc.a",
    target_compatible_with = select({
        "@platforms//os:linux": ["@platforms//cpu:x86_64"],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
    deps = [
        ":gcc",
        ":math",
        ":mvec",
        ":util",
    ],
)

# This is a group of all the system libraries we need. The actual glibc library is split
# out to fix link ordering problems that cause false undefined symbol positives.
feature_import(
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
