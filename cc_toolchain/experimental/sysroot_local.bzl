"""
How to add this experimental sysroot
load(":sysroot_local.bzl", "sysroot_local")

sysroot_local(
    name = "sysroot_local",
)
"""

def _sysroot_local_impl(ctx):
    print("_sysroot_local_impl: Create sysroot_local")

    print("_sysroot_local_impl: ctx.toolchains: ")
    print(dir(ctx.toolchains))
    print("_sysroot_local_impl: =========================")
    print(dir(ctx.toolchains["@rules_cc//cc:toolchain_type"]))

    print("_sysroot_local_impl: cc_common: ")
    print(dir(cc_common))

sysroot_local = rule(
    implementation = _sysroot_local_impl,
)
