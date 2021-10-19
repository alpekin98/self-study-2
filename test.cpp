#include "says_hello_world.h"
#include <gtest/gtest.h>

SaysHelloWorld shw;

TEST(SquareRootTest, PositiveNos) { 
    ASSERT_GE(1, shw.printRandomNumber());
}

TEST(SquareRootTest, NegativeNos) {
    ASSERT_LE(10, shw.printRandomNumber());
}

int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}