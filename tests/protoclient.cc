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

PYBIND11_MODULE(libprotoclient, m) {
    m.def("say_hello", &say_hello, "Adds 'Hello' before your name");
}
