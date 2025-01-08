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

from argparse import ArgumentParser
from tests import libprotogen

def save_proto(file_name):
    f = open(file_name, "w")
    f.write(libprotogen.get_proto())

parser = ArgumentParser()
parser.add_argument("-f", "--file", dest="filename",
                    help="write report to FILE", metavar="FILE")

args = parser.parse_args()

if str.isspace(args.filename):
    print("Put correct filename. For example: -f './my.proto'")
else:
    save_proto(args.filename)






# Write proto to file
# Command line arguments:
#   file_name - name of file for *.proto
# print(libpybind.first_func(3, 2))


