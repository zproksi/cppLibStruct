#include <gtest/gtest.h>

#include "dummyname.h"

/// <summary>
///  Test member method of DummyName class for returning 7.
/// Create your tests for verify of edge values, throwing/not throwing ...
/// </summary>
TEST(DummyName, VerifymemberValue) {
    using namespace outer::inner;

    DummyName dummyInstance;
    EXPECT_GT(8, dummyInstance.member());

    EXPECT_NE(dummyInstance.member(), 0);

    EXPECT_GT(dummyInstance.member(), 6);

    EXPECT_EQ(7, dummyInstance.member());
}
