#include <iostream>
#include "tests/hello_world.pb.h"

using namespace std;

int main() {
  helloworld::HelloRequest request;
  request.set_name("World");

  // Serialize the message to a string
  string output;
  request.SerializeToString(&output);

  // Deserialize the message from the string
  helloworld::HelloRequest deserialized_request;
  deserialized_request.ParseFromString(output);

  cout << "Hello, " << deserialized_request.name() << "!" << endl;

  return 0;
}

