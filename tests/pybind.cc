//
// Created by yuriit on 12/23/24.
//
// TODO: Should build for tool execution platform
//

#include "pybind11/pybind11.h"

int first_func(int a, int b) {
  return a + b + 13;
}

std::string get_proto() {
    std::string proto = "syntax = \"proto3\";\n";

    proto.append("package protobuf;\n");
    proto.append("message HelloRequest {\n");
    proto.append("\tstring name = 1;\n");
    proto.append("\tint32 age = 2;\n");
    proto.append("}\n");
    proto.append("message HelloReply {\n");
    proto.append("\tstring message = 1;\n");
    proto.append("};\n");

    return proto;
}

PYBIND11_MODULE(libpybind, m) {
    m.doc() = "pybind11 example plugin";
    m.def("first_func", &first_func, "The first function");
    m.def("get_proto", &get_proto, "Returns content of proto file");
}
