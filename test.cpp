#include "says_hello_world.h"
#include <gtest/gtest.h>

SaysHelloWorld shw;

TEST(RandomNumberTest, LessOrEqual) { 
    ASSERT_LE(1, shw.printRandomNumber());
}

TEST(RandomNumberTest, GreatOrEqual) {
    ASSERT_GE(10, shw.printRandomNumber());
}

int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}