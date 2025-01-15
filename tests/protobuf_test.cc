#include <iostream>
#include <cassert>
#include <fstream>
#include "tests/protobuf_hello.pb.h"
#include "gtest/gtest.h"

std::string setAndGetName(std::string name) {
  protobuf::HelloRequest request;
  request.set_name(name);

  // Serialize the message to a string
  std::string output;
  request.SerializeToString(&output);

  // Deserialize the message from the string
  protobuf::HelloRequest deserialized_request;
  deserialized_request.ParseFromString(output);

  return deserialized_request.name();
}

TEST(ProtobufTest, ProtobufTest) {
  EXPECT_EQ("Julius", setAndGetName("Julius"));
}