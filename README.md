# Build linux x86_64
bazel build //tests:hello_world --config=x86_64

# Build linux aarch64
bazel build //tests:hello_world --config=aarch64