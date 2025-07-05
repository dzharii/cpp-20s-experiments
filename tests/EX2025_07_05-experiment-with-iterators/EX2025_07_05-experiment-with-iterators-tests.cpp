#include "doctest/doctest.h"
#include "EX2025_07_05-experiment-with-iterators/EX2025_07_05-experiment-with-iterators.hpp"
#include <vector>

TEST_CASE("double_even_numbers")
{
    std::vector<int> input = {1, 2, 3, 4, 5, 6};
    std::vector<int> expected = {4, 8, 12};
    auto result = iterators_experiment::double_even_numbers(input);
    CHECK(result == expected);
}
