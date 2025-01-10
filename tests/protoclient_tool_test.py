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

import unittest
from tests import protoclient

class TestProtoClient(unittest.TestCase):
    def test(self):
        self.assertEqual("Hello, Julius Caesar", protoclient.say_hello("Julius Caesar"))

if __name__ == '__main__':
    unittest.main()