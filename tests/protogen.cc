//
// Created by yuriit on 12/23/24.
//
// TODO: Should build for tool execution platform
//

#include "pybind11/pybind11.h"

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

//int hash_code(int a) {
//    int start = 12;
//    return 31 * start + a;
//}

PYBIND11_MODULE(libprotogen, m) {
    m.doc() = "pybind11 proto generator plugin";
    m.def("get_proto", &get_proto, "Generates content of proto file");
    //m.def("hash_code", &hash_code, "The first function");
}
