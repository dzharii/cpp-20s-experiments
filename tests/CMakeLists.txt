cmake_minimum_required(VERSION 3.15)

# List all files containing tests. (Change as needed)
set(TESTFILES        # All .cpp files in tests/
    main.cpp
    EX2025_07_05-experiment-with-iterators/EX2025_07_05-experiment-with-iterators-tests.cpp 
)
set(TEST_MAIN unit_tests)   # Default name for test executable (change if you wish).
set(TEST_RUNNER_PARAMS "--success=1")  # Any arguemnts to feed the test runner (change as needed).

# --------------------------------------------------------------------------------
#                         Make Tests (no change needed).
# --------------------------------------------------------------------------------
add_executable(${TEST_MAIN} ${TESTFILES})
target_include_directories(${TEST_MAIN} PUBLIC
    ${PROJECT_SOURCE_DIR}/tests/include
    ${PROJECT_SOURCE_DIR}/src
)

target_link_libraries(${TEST_MAIN} PRIVATE
    EX2025_07_05-experiment-with-iterators
)



# Ensure the test executable is placed in the same directory as the main application.
set_target_properties(${TEST_MAIN} PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)

add_test(
    # Use some per-module/project prefix so that it is easier to run only tests for this module
    NAME ${LIBRARY_NAME}.${TEST_MAIN}
    COMMAND $<TARGET_FILE:${TEST_MAIN}> ${TEST_RUNNER_PARAMS})
