load(
    "@llvm_mini_toolchain//cc_toolchain:cc_toolchain_import.bzl",
    "cc_toolchain_import",
)

exports_files(glob(["bin/*"]))

CLANG_VERSION = "18"

filegroup(
    name = "all",
    srcs = glob(["**/*"]),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

filegroup(
    name = "clang",
    srcs = [
        "bin/clang",
    ],
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

filegroup(
    name = "clang++",
    srcs = [
        "bin/clang++",
    ],
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

filegroup(
    name = "ld",
    srcs = [
        "bin/ld.lld",
    ],
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)

filegroup(
    name = "ar",
    srcs = ["bin/llvm-ar"],
    visibility = ["//visibility:public"],
)

cc_toolchain_import(
    name = "clang_includes",
    hdrs = glob([
        "lib/clang/*/*.h",
        "lib/clang/*/include/*.h",
        "lib/clang/*/include/**/*.h",
    ]),
    includes = [
        "lib/clang/{clang_version}".format(clang_version = CLANG_VERSION),
        "lib/clang/{clang_version}/include".format(clang_version = CLANG_VERSION),
    ],
    target_compatible_with = select({
        "@platforms//os:linux": [],
    }),
    visibility = ["@llvm_mini_toolchain//config:__pkg__"],
)
