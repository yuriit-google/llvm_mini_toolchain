# MIT License
#
# Copyright (c) 2024 Google LLC
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#load("@bazel_tools//tools/build_defs/repo:local.bzl", "local_repository")
load(":http_archive_bazel7.bzl", "http_archive_bazel7")  # Remove this line after updating bazel to 7.3.0 or newer

def cc_toolchain_deps():
    if "sysroot_linux_x86_64" not in native.existing_rules():
        http_archive(
            name = "sysroot_linux_x86_64",
            sha256 = "d19c4b010a75eb9d599f055c834a993d848880c936d7d91366a7c3765ad028ae",
            urls = ["https://media.githubusercontent.com/media/yuriit-google/binutils/refs/heads/main/ubuntu18_x86_64_sysroot.tar.xz"],
            build_file = "//config:sysroot_linux_x86_64.BUILD",
            strip_prefix = "ubuntu18_x86_64_sysroot",
        )

    if "sysroot_linux_aarch64" not in native.existing_rules():
        http_archive(
            name = "sysroot_linux_aarch64",
            sha256 = "d883a1d664500f11bb49aa70c650a9e68d49341324c447f9abda77ec2f335ac5",
            urls = ["https://media.githubusercontent.com/media/yuriit-google/binutils/refs/heads/main/ubuntu18_aarch64-sysroot.tar.xz"],
            build_file = "//config:sysroot_linux_aarch64.BUILD",
            strip_prefix = "ubuntu18_aarch64-sysroot",
        )

    if "sysroot_macos_aarch64" not in native.existing_rules():
        native.new_local_repository(
            name = "sysroot_macos_aarch64",
            build_file = "//config:sysroot_macos_aarch64.BUILD",
            path = "sysroots/macos_arm64/MacOSX.sdk",
        )

    if "llvm_linux_x86_64" not in native.existing_rules():
        # Replace 'http_archive_bazel7' by 'http_archive' after updating bazel to 7.3.0 or newer
        http_archive_bazel7(
            name = "llvm_linux_x86_64",
            url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.8/clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04.tar.xz",
            sha256 = "54ec30358afcc9fb8aa74307db3046f5187f9fb89fb37064cdde906e062ebf36",
            build_file = "//config:llvm_linux_x86_64.BUILD",
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

    if "llvm_macos_aarch64" not in native.existing_rules():
        http_archive(
            name = "llvm_macos_aarch64",
            url = "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.8/clang+llvm-18.1.8-arm64-apple-macos11.tar.xz",
            sha256 = "4573b7f25f46d2a9c8882993f091c52f416c83271db6f5b213c93f0bd0346a10",
            build_file = "//config:llvm_macos_aarch64.BUILD",
            strip_prefix = "clang+llvm-18.1.8-arm64-apple-macos11",
        )
