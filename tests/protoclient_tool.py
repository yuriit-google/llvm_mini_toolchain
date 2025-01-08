# Build this script by py_binary
# Call this py_binary in genrule
#
# proto_library(
#     name = "hello_proto",
#     srcs = ["hello.proto"],
#     visibility = ["//visibility:public"],
# )

#
# Tools - for Linux (any program which run during build on host machine)
# Target - for mac
#

from tests import libprotoclient

print(libprotoclient.say_hello("Julius Caesar"))
