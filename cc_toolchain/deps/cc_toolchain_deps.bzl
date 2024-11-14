load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":new_http_archive.bzl", "new_http_archive")
load(":custom_http_archive.bzl", "custom_http_archive")

def cc_toolchain_deps():
    if "sysroot_linux_x86_64_glibc2_27" not in native.existing_rules():
        http_archive(
            name = "sysroot_linux_x86_64_glibc2_27",
            sha256 = "d19c4b010a75eb9d599f055c834a993d848880c936d7d91366a7c3765ad028ae",
            urls = ["https://media.githubusercontent.com/media/yuriit-google/binutils/refs/heads/main/ubuntu18_x86_64_sysroot.tar.xz"],
            build_file = "//config:sysroot_linux_x86_64_glibc2_27.BUILD",
            strip_prefix = "ubuntu18_x86_64_sysroot",
        )

    if "sysroot_linux_aarch64_glibc2_27" not in native.existing_rules():
        http_archive(
            name = "sysroot_linux_aarch64_glibc2_27",
            sha256 = "d883a1d664500f11bb49aa70c650a9e68d49341324c447f9abda77ec2f335ac5",
            urls = ["https://media.githubusercontent.com/media/yuriit-google/binutils/refs/heads/main/ubuntu18_aarch64-sysroot.tar.xz"],
            build_file = "//config:sysroot_linux_aarch64_glibc2_27.BUILD",
            strip_prefix = "ubuntu18_aarch64-sysroot",
        )

    if "llvm18_linux_x86_64" not in native.existing_rules():
        new_http_archive(
            name = "llvm18_linux_x86_64",
            url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.8/clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04.tar.xz",
            sha256 = "54ec30358afcc9fb8aa74307db3046f5187f9fb89fb37064cdde906e062ebf36",
            build_file = "//config:llvm18_linux_x86_64.BUILD",
            strip_prefix = "clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04",
            remote_file_urls = {
                "lib/libtinfo.so.5": [ "https://raw.githubusercontent.com/yuriit-google/binutils/refs/heads/main/libtinfo-binary/libtinfo.so.5" ]
            },
            remote_file_integrity = {
                "lib/libtinfo.so.5": "sha256-3AfQHdSwWRIn3v7sjDRd+IyZzex0FzpDSslg1eXV4ts=",
            },
        )

#        custom_http_archive(
#            name = "llvm18_linux_x86_64",
#            url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.8/clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04.tar.xz",
#            sha256 = "54ec30358afcc9fb8aa74307db3046f5187f9fb89fb37064cdde906e062ebf36",
#            build_file = "//config:llvm18_linux_x86_64.BUILD",
#            strip_prefix = "clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04",
#            remote_file_urls = {
#                "lib/libtinfo.so.5-binary.tar.xz": [ "https://media.githubusercontent.com/media/yuriit-google/binutils/refs/heads/main/libtinfo.so.5_x86_64.tar.xz" ]
#            },
#            remote_file_integrity = {
#                "lib/libtinfo.so.5-binary.tar.xz": "sha256-TMensGEmAYFBG4341Gv630GYbnpZl2fEvdAPEcgYlZc=",
#            },
#        )