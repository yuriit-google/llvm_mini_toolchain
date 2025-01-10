#include <iostream>
#include <string>
#include <vector>

#include "absl/algorithm/algorithm.h"
#include "absl/strings/str_join.h"
#include "absl/strings/str_split.h"
#include "absl/container/flat_hash_map.h"
#include "absl/container/flat_hash_set.h"

int main() {
  std::vector<std::string> v1 = absl::StrSplit("Hello,Abseil,StrSplit,and,StrSplit,methods", ',');
  std::string s1 = absl::StrJoin(v1, " ");
  std::cout << s1 << "!\n";

  absl::flat_hash_map<int, std::string> m1 = {{1, "Hello"}, {2, "Abseil flat_hash_map"}, };
  std::cout << m1.at(1) << " " << m1.at(2) << "!\n";

  std::vector<int> nums = {20, 13, 50, 16, 77, 8, 99, 10};
  absl::c_sort(nums);

  absl::flat_hash_set<std::string> st1 = absl::StrSplit(s1, " ");
  auto it = absl::c_find(nums, 13);

  return 0;
}