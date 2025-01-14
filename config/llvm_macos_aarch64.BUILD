load(
    "@llvm_mini_toolchain//features:cc_toolchain_import.bzl",
    "cc_toolchain_import",
)

exports_files(glob(["bin/*"]))

CLANG_VERSION = "18"

filegroup(
    name = "all",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "clang",
    srcs = [
        "bin/clang",
    ],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "clang++",
    srcs = [
        "bin/clang++",
    ],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "ld",
    srcs = [
        "bin/ld.lld",
    ],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "ar",
    srcs = ["bin/llvm-libtool-darwin"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "install_name_tool_darwin",
    srcs = ["bin/llvm-install-name-tool"],
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
        "@platforms//os:macos": [],
    }),
    visibility = ["//visibility:public"],
)
