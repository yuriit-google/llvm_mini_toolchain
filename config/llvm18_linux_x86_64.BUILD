load(
    "@llvm_mini_toolchain//features:cc_toolchain_import.bzl",
    "cc_toolchain_import",
)

print("------------------------------ llvm18_linux_x86_64.BUILD ----------------------------------------")

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
