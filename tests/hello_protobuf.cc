#include <iostream>
#include <fstream>
#include "tests/hello.pb.h"

using namespace std;

void sayHello() {
  protobuf::HelloRequest request;
  request.set_name("Hello Protobuf");

  // Serialize the message to a string
  string output;
  request.SerializeToString(&output);

  // Deserialize the message from the string
  protobuf::HelloRequest deserialized_request;
  deserialized_request.ParseFromString(output);

  cout << "Say, " << deserialized_request.name() << "!" << endl;
}

int main() {
  sayHello();
  return 0;
}