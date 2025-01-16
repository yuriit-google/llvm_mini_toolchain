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

#include <iostream>
#include "pybind11/pybind11.h"
#include "tests/my.pb.h"

std::string echo_name(std::string words) {
    if(words.empty()) {
      words = "Unknown";
    }

    protobuf::HelloRequest request;
    request.set_name(words);

    // Serialize the message to a string
    std::string output;
    request.SerializeToString(&output);

    // Deserialize the message from the string
    protobuf::HelloRequest deserialized_request;
    deserialized_request.ParseFromString(output);

    //std::cout << "Say, " << deserialized_request.name() << "!" << std::endl;
    return deserialized_request.name();
}

std::string say_hello(std::string name) {
    return "Hello, " + echo_name(name);
}

PYBIND11_MODULE(protoclient, m) {
    m.def("say_hello", &say_hello, "Adds 'Hello' before your name");
}
