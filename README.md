# Hermetic builds
Project supports hermetic builds on:
* Linux x86_64 - Done
* macOS - <i>In Progress</i>

You could run hermetic builds by run

`bazel build //tests/...`

If project doesn't support cross-platform builds for specified platform,
it will use host utilities and sysroot for running build.

# Cross-platform builds
Project supports cross-platform builds only on Linux x86_64 executor 
and allows build for such targets:
* Linux aarch64 - Done
* macOS aarch64 - <i>In Progress</i>

### Build for Linux aarch64
`bazel build //tests/... --platforms=//config:linux_aarch64`

### Build for macOS aarch64 - <i>In Progress</i>
`bazel build //tests/... --platforms=//config:macos_aarch64`

# Non-hermetic build
En executor and a target are the same.

`bazel build //tests/... --//config:hermetic_cc=False`

# TODOs
- [X] Create custom repository rule which downloads LLVM18 and libtinfo5
- [X] Test prototype with protobuf stubs. Make sure that new toolchains works correctly with cc_proto_library (toolchain for executor)
- [X] Import abseil library and write tests
- [X] Add support of hermetic build without arguments
- [ ] Add macOS target support (aarch64 only) - <i>In Progress</i>
- [ ] Check -std=c++17 flag
- [ ] Add multiple tools (clang versions) and sysroots
