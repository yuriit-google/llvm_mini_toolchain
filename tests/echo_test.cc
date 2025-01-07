#include <iostream>
#include <cassert>
#include <vector>
#include "echo.h"

using namespace std;

int main() {

  std::string s = "The string was echoed!";
  assert(s.compare(echo("The string was echoed!")));

  return 0;
}

