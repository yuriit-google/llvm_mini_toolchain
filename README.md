# Build x86_64
bazel build //tests:hello_world --config=x86_64

# Build aarch64
bazel build //tests:hello_world --config=aarch64