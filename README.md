# Constraints
- <s>LLVM 18 portable distribution depends on libtinfo5 library, so please install it: `sudo apt install libtinfo5`</s>

# Linux x86_64. Build all targets
`bazel build //tests/... --config=hermetic_linux_x86_64`

# Linux x86_64. Run tests (works on Linux x86_64 only)
`bazel test //tests/... --config=hermetic_linux_x86_64`

# Linux aarch64. Build all targets
`bazel build //tests/... --config=hermetic_linux_aarch64`

# Linux aarch64. Run tests (works on Linux aarch64 only)
`bazel test //tests/... --config=hermetic_linux_aarch64`

# TODOs
- [X] Create custom repository rule which downloads LLVM18 and libtinfo5
- [X] Test prototype with protobuf stubs. Make sure that new toolchains works correctly with cc_proto_library (toolchain for executor)
- [X] Import abseil library and write tests
- [ ] Add support of local machine toolchain for build without arguments (for example k8|linux for x86_64)
- [ ] Add macOS target support (arm64 only)
