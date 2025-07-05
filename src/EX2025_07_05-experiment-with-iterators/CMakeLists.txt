cmake_minimum_required(VERSION 3.15)

set(EXPERIMENT_NAME EX2025_07_05-experiment-with-iterators)
set(EXPERIMENT_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/EX2025_07_05-experiment-with-iterators.cpp
)

add_library(${EXPERIMENT_NAME} ${EXPERIMENT_SOURCES})

target_include_directories(${EXPERIMENT_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(${EXPERIMENT_NAME} PUBLIC
    ${LIBRARY_NAME}
)

set_target_properties(${EXPERIMENT_NAME} PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)
