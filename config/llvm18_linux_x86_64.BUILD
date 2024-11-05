load(
    "@llvm_mini_toolchain//features:feature_import.bzl",
    "feature_import",
)

print("------------------------------ llvm18_linux_x86_64.BUILD ----------------------------------------")

exports_files(glob(["bin/*"]))

CLANG_VERSION = "18"

filegroup(
    name = "all",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "compiler_files",
    srcs = [
        "bin/clang",
        "bin/clang++",
    ],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "linker_files",
    srcs = [
        "bin/ld.lld",
    ],
    visibility = ["//visibility:public"],
)

feature_import(
    name = "llvm_libunwind",
    hdrs = glob([
        "lib/clang/*/include/unwind.h",
    ]),
    #includes = [
    #    "lib/clang/{clang_version}".format(clang_version = CLANG_VERSION),
    #    "lib/clang/{clang_version}/include".format(clang_version = CLANG_VERSION),
    #],
    runtime_path = "/usr/lib/x86_64-linux-gnu",
    shared_library = "lib/libunwind.so",
    static_library = "lib/x86_64-unknown-linux-gnu/libunwind.a",
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["//visibility:public"],
    deps = [
        "@llvm_mini_toolchain//config:libc"
    ],
)

feature_import(
    name = "llvm_libcxx",
    #hdrs = glob(["include/c++/v1/**"]),
    #includes = ["include/c++/v1"],
    static_library = "lib/x86_64-unknown-linux-gnu/libc++.a",
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["//visibility:public"],
    deps = [
        "@llvm_mini_toolchain//config:libc",
        "@llvm_mini_toolchain//config:libunwind",
        ":llvm_config_site",
    ],
)

feature_import(
    name = "llvm_config_site",
    #hdrs = ["include/x86_64-unknown-linux-gnu/c++/v1/__config_site"],
    #includes = ["include/x86_64-unknown-linux-gnu/c++/v1"],
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["//visibility:public"],
)

feature_import(
    name = "llvm_libcxx_abi",
    #hdrs = glob(["include/c++/v1/**"]),
    #includes = ["include/c++/v1"],
    static_library = "lib/x86_64-unknown-linux-gnu/libc++abi.a",
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["//visibility:public"],
    deps = [
        "@llvm_mini_toolchain//config:libc",
        "@llvm_mini_toolchain//config:pthread",
    ],
)

feature_import(
    name = "llvm_clang",
    #hdrs = glob([
    #    "lib/clang/*/*.h",
    #    "lib/clang/*/include/*.h",
    #    "lib/clang/*/include/**/*.h",
    #]),
    #includes = [
    #    "lib/clang/{clang_version}".format(clang_version = CLANG_VERSION),
    #    "lib/clang/{clang_version}/include".format(clang_version = CLANG_VERSION),
    #],
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["//visibility:public"],
)
