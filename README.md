# Hermetic Toolchains for ML

This project provides Bazel rules to achieve hermetic and cross-platform builds.

#### Hermetic builds benefits:
* Reproducibility: Every build produces identical results regardless of the developer's machine environment.
* Consistency: Eliminates "works on my machine" issues, ensuring builds are consistent across different development environments.
* Isolation: Builds are isolated from the host system, minimizing unexpected dependencies and side effects.

#### Cross-Platform Builds:
* Single Source of Truth: Develop and maintain a single codebase that can be built for various target platforms (e.g., Linux, macOS).
* Efficiency: Streamlines the build and release process for multiple platforms.

## C++ toolchains for hermetic builds
Project supports hermetic builds on:
* Linux x86_64
* macOS aarch64

You could run hermetic build tests with help of command

`bazel test //tests:all`

If project doesn't support cross-platform builds for specified platform,
it will use host utilities and host sysroot for running such build.

## C++ toolchains for cross-platform builds
Project supports cross-platform builds only on Linux x86_64 executor 
and allows build for such targets:
* Linux aarch64
* macOS aarch64

#### Build for Linux aarch64
`bazel build //tests/... --platforms=//config:linux_aarch64`

#### Build for macOS aarch64
`bazel build //tests/... --platforms=//config:macos_aarch64`

### Non-hermetic build
En executor and a target are the same.

`bazel build //tests/... --//config:hermetic_cc=False`
