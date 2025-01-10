#include "echo.h"
#include "gtest/gtest.h"

TEST(EchoTest, EchoTest) {
  EXPECT_EQ("You say: The string was echoed!", echo("The string was echoed!"));
}

