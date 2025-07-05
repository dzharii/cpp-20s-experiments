#include "EX2025_07_05-experiment-with-iterators.hpp"
#include <ranges>
#include <vector>

namespace iterators_experiment {
std::vector<int> double_even_numbers(const std::vector<int>& numbers) {
    auto results = numbers
        | std::views::filter([](int n) { return n % 2 == 0; })
        | std::views::transform([](int n) { return n * 2; });
    return {results.begin(), results.end()};
}
}