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