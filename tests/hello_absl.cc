#include <iostream>
#include <string>
#include <vector>

#include "absl/strings/str_join.h"

int main() {
  std::vector<std::string> v = {"Hello", "Abseil"};
  std::string s = absl::StrJoin(v, " ");

  std::cout << "Joined string: " << s << "!\n";

  return 0;
}