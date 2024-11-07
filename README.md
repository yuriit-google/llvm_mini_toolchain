bazel build //tests:hello_world -s \
    --platforms=//config:linux_aarch64_platform \
    --host_platform=//config:linux_aarch64_platform \
    --verbose_failures