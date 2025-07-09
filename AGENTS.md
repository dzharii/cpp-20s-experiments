# Agent and Developer Guide

This document provides instructions for agents and developers on how to work with the `cpp-20s-experiments` repository.

## 1. Project Overview

This project is a sandbox for various C++20 (and newer) experiments. Each experiment is designed to be self-contained, with its own source code, library definition, and corresponding tests. The goal is to explore different C++ features in an organized manner.

## 2. Directory Structure

The key directories are:

-   `src/`: Contains the source code for individual experiments. Each experiment resides in its own subdirectory.
-   `tests/`: Contains the tests for the experiments. The structure mirrors the `src` directory.
-   `app/`: A simple application that can be used to run or demonstrate experiments.
-   `cmake/`: Contains helper modules for the CMake build system.
-   `build-*/`: Scripts to automate the build process for different platforms and configurations.

## 3. Workflow: Adding a New Experiment

Follow these steps to add a new experiment to the project.

### Step 1: Choose a Name and Create Source Directory

First, decide on a descriptive name for your experiment. Use the convention `EXYYYY_MM_DD-short-description`.

Create a new directory inside `src/` with your chosen name.

```sh
# Example
mkdir src/EX2025_07_08-my-new-feature
```

### Step 2: Create Source and CMake Files

Inside your new directory (`src/<experiment_name>`), create the following files:

1.  **`<experiment_name>.hpp`**: The header file for your experiment.
2.  **`<experiment_name>.cpp`**: The source file for your experiment.
3.  **`CMakeLists.txt`**: The build script for your experiment's library.

Use the following template for your `src/<experiment_name>/CMakeLists.txt`. **Remember to replace `<experiment_name>` with your actual experiment name.**

```cmake
# src/<experiment_name>/CMakeLists.txt

cmake_minimum_required(VERSION 3.15)

set(EXPERIMENT_NAME <experiment_name>)
set(EXPERIMENT_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/<experiment_name>.cpp
)

add_library(${EXPERIMENT_NAME} ${EXPERIMENT_SOURCES})

target_include_directories(${EXPERIMENT_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

# This links to the main project library, if needed.
# You can remove this if your experiment is fully standalone.
target_link_libraries(${EXPERIMENT_NAME} PUBLIC
    ${LIBRARY_NAME}
)

set_target_properties(${EXPERIMENT_NAME} PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)
```

### Step 3: Update Root `CMakeLists.txt`

Open the main `CMakeLists.txt` file in the project root and add your new experiment's source directory. Find the section for locating files and add your `add_subdirectory` line.

```cmake
# In /CMakeLists.txt

# ...
# --------------------------------------------------------------------------------
#                         Locate files (change as needed).
# --------------------------------------------------------------------------------
add_subdirectory(src/EX2025_07_05-experiment-with-iterators)
add_subdirectory(src/<experiment_name>) # <-- ADD THIS LINE
# ...
```

### Step 4: Create Test Files

Every experiment requires tests.

1.  Create a corresponding directory in `tests/`:
    ```sh
    # Example
    mkdir tests/EX2025_07_08-my-new-feature
    ```
2.  Create your test source file inside this new directory: `tests/<experiment_name>/<experiment_name>-tests.cpp`.
3.  Write your tests using the `doctest` framework.

### Step 5: Update `tests/CMakeLists.txt`

Open `tests/CMakeLists.txt` and update it to include your new test file and link against your new experiment's library.

1.  **Add the test file path** to the `TESTFILES` variable.
2.  **Add the library name** to the `target_link_libraries` call.

```cmake
# In /tests/CMakeLists.txt

# ...
# List all files containing tests. (Change as needed)
set(TESTFILES        # All .cpp files in tests/
    main.cpp
    EX2025_07_05-experiment-with-iterators/EX2025_07_05-experiment-with-iterators-tests.cpp
    <experiment_name>/<experiment_name>-tests.cpp # <-- ADD THIS LINE
)
# ...
# ...
target_link_libraries(${TEST_MAIN} PRIVATE
    EX2025_07_05-experiment-with-iterators
    <experiment_name> # <-- ADD THIS LINE
)
# ...
```

## 4. Workflow: Adding a Performance Benchmark

This project uses Google Benchmark for performance testing. Benchmarks are located in the `app/` directory.

### Step 1: Create a Benchmark File

Create a new `.cpp` file in the `app/` directory (e.g., `app/my_awesome_benchmark.cpp`). Use the following basic template:

```cpp
#include <benchmark/benchmark.h>

// A function to benchmark
static void BM_MyFunction(benchmark::State& state) {
  for (auto _ : state) {
    // Code to benchmark goes here
  }
}
BENCHMARK(BM_MyFunction);

// You can add more benchmarks in the same file

BENCHMARK_MAIN();
```

### Step 2: Update Root `CMakeLists.txt`

Open the root `CMakeLists.txt` and add a new executable for your benchmark.

1.  **Add the executable**: Find the "Add benchmark executable" section and add a new `add_executable` and `target_link_libraries` block for your benchmark.
2.  **Add to PROJECTS**: Add the name of your new benchmark executable to the `PROJECTS` list to ensure it gets the correct C++ standard settings.

```cmake
# In /CMakeLists.txt

# ... (near the other executables)

# Add your new benchmark executable
add_executable(my_awesome_benchmark app/my_awesome_benchmark.cpp)
target_link_libraries(my_awesome_benchmark PRIVATE benchmark::benchmark)
target_set_warnings(my_awesome_benchmark ENABLE ALL AS_ERROR ALL DISABLE Annoying)
target_enable_lto(my_awesome_benchmark optimized)

# ...

# Set the properties you require...
set(PROJECTS
    ${MAIN_APP_UI}
    hello_benchmark
    my_awesome_benchmark # <-- ADD THIS LINE
)
```

## 5. Building and Testing

Use the provided build scripts (e.g., `build-release-on-windows.cmd` or `build-release-on-linux.sh`) to configure and build the project.

After a successful build, you can run the unit tests directly from the build output directory (e.g., `build-release/bin/unit_tests.exe`) or by using `ctest` from within the build directory.

The benchmark executables will be located in the same `bin` directory (e.g., `build-release/bin/hello_benchmark.exe`).

## 6. Code Style

This project uses `.clang-format` to enforce a consistent code style. Please format your code before committing.

## Emacs specific configuration

When I ask to tweak something in Emacs, you should be aware that I keep a special Emacs configuration in `black-magic-emacs-init`.
To understand how it works, start with `init.el`. This file contains helpful comments and references.
It's important to understand the modular configuration: from `init.el`, the file `init-config.org` is referenced. This file tangles to `init-config.el` when Emacs runs, but you should always edit the `.org` file, since this is the source, when I request changes.
Another example is:

```emacs-lisp
;; [dired] Emacs Directory Editor specific configuration 
(org-babel-load-file (expand-file-name "./black-magic-emacs-init/init-dired/init-dired.org"))
```

Here, I’m loading a specific part of the configuration for a specific part of Emacs. I’d like to keep this modular approach, and when I ask to tweak something in a specific module, find the existing file or create a new one.
Remember: we always make edits in `.org` files when it comes to Emacs configuration.

Do not run these files, but you can examine the source code:
* `summon-emacs.cmd`
* `summon-emacs.ps1`


