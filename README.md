# Constraints
- <s>LLVM 18 portable distribution depends on libtinfo5 library, so please install it: `sudo apt install libtinfo5`</s>

# Linux x86_64
# Build
`bazel build //tests:hello_world --config=x86_64`

# Run tests
`bazel test //tests/... --config=x86_64`

# Linux aarch64
# Build
`bazel build //tests:hello_world --config=aarch64`

# Run tests
`bazel test //tests/... --config=aarch64`

# TODOs
- [X] Create custom repository rule which downloads LLVM18 and libtinfo5
- [X] Test prototype with protobuf stubs. Make sure that new toolchains works correctly with cc_proto_library (toolchain for executor)
- [X] Import abseil library and write tests
- [ ] Add support of local machine toolchain for build without arguments (for example k8|linux for x86_64)
- [ ] Add darwin os target support (arm64 only)
