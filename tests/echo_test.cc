#include <iostream>
#include <cassert>
#include <vector>
#include "echo.h"

using namespace std;

int main() {

  assert("You say: The string was echoed!" == echo("The string was echoed!"));

  return 0;
}

