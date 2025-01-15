/* MIT License

Copyright (c) 2024 Google LLC

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
================================================================================*/

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

PYBIND11_MODULE(protogen, m) {
    m.doc() = "pybind11 proto generator plugin";
    m.def("get_proto", &get_proto, "Generates content of proto file");
    //m.def("hash_code", &hash_code, "The first function");
}
