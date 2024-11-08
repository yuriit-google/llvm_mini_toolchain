load(
    "@llvm_mini_toolchain//features:cc_toolchain_import.bzl",
    "cc_toolchain_import",
)

print("------------------------------ llvm18_linux_x86_64.BUILD ----------------------------------------")

exports_files(glob(["bin/*"]))

CLANG_VERSION = "19"

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
