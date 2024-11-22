load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#load("@bazel_tools//tools/build_defs/repo:local.bzl", "new_local_repository")
load(":http_archive_bazel7.bzl", "http_archive_bazel7")  # Remove this line after updating bazel to 7.3.0 or newer

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

    #if "sysroot_local" not in native.existing_rules():
    #    new_local_repository(
    #        name = "sysroot_local",
    #        build_file = "//config:sysroot_local_posix.BUILD",
    #        path = "/",
    #    )

    if "llvm_linux_x86_64" not in native.existing_rules():
        # Replace 'http_archive_bazel7' by 'http_archive' after updating bazel to 7.3.0 or newer
        http_archive_bazel7(
            name = "llvm_linux_x86_64",
            url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.8/clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04.tar.xz",
            sha256 = "54ec30358afcc9fb8aa74307db3046f5187f9fb89fb37064cdde906e062ebf36",
            build_file = "//config:llvm18_linux_x86_64.BUILD",
            strip_prefix = "clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04",
            remote_file_urls = {
                "lib/libtinfo.so.5": ["https://raw.githubusercontent.com/yuriit-google/binutils/refs/heads/main/libtinfo-binary/libtinfo.so.5"],
                "lib/libtinfo5-copyright.txt": ["https://raw.githubusercontent.com/yuriit-google/binutils/refs/heads/main/libtinfo-binary/copyright"],
            },
            remote_file_integrity = {
                "lib/libtinfo.so.5": "sha256-3AfQHdSwWRIn3v7sjDRd+IyZzex0FzpDSslg1eXV4ts=",
                "lib/libtinfo5-copyright.txt": "sha256-Xo7pAsiQbdt3ef023Jl5ywi1H76/fAsamut4rzgq9ZA=",
            },
        )
