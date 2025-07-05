cmake_minimum_required(VERSION 3.15)

# Set project name, version and laguages here. (change as needed)
# Version numbers are available by including "exampleConfig.h" in
# the source. See exampleConfig.h.in for some more details.
project(CPP_20S_EXPERIMENTS VERSION 0.0.0.1 LANGUAGES CXX)

# Determine if using a multi-configuration generator
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Options: Things you can set via commandline options to cmake (e.g. -DENABLE_LTO=[ON|OFF])
option(ENABLE_WARNINGS_SETTINGS "Allow target_set_warnings to add flags and defines.
                                 Set this to OFF if you want to provide your own warning parameters." ON)
option(ENABLE_LTO "Enable link time optimization" ON)

# Include stuff. No change needed.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
include(ConfigSafeGuards)
include(Colors)
include(LTO)
include(Warnings)
include(FetchContent)

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

# Check for LTO support.
find_lto(CXX)

# --------------------------------------------------------------------------------
#                         Locate files (change as needed).
# --------------------------------------------------------------------------------
add_subdirectory(src/EX2025_07_05-experiment-with-iterators)

set(LIBRARY_NAME cpp-20s-experiments-lib)  # Default name for the library built from src/*.cpp (change if you wish)
set(MAIN_APP_UI cpp-20s-experiments) # Main application

# --------------------------------------------------------------------------------
#                            Build! (Change as needed)
# --------------------------------------------------------------------------------






# target_compile_options(${LIBRARY_NAME} ... )  # For setting manually.

# Add an executable for the file app/main.cpp.
# If you add more executables, copy these lines accordingly.
# Add an executable main
set(MAIN_APP_UI_SOURCE
    # source files here  #109ufj9e4bt
)
add_executable(${MAIN_APP_UI} app/main.cpp)   # Name of exec. and location of file.
# #109ufj9e4bt
# target_sources(${MAIN_APP_UI} PRIVATE ${MAIN_APP_UI_SOURCE})

target_link_libraries(${MAIN_APP_UI} PRIVATE
)  # Link the executable to library (if it uses it).
target_set_warnings(${MAIN_APP_UI} ENABLE ALL AS_ERROR ALL DISABLE Annoying) # Set warnings (if needed).
target_enable_lto(${MAIN_APP_UI} optimized)  # enable link-time-optimization if available for non-debug configurations

if(MSVC)
    target_compile_options(${MAIN_APP_UI} PRIVATE /wd4244)
else()
# Nothing yet
endif()



# Set the properties you require, e.g. what C++ standard to use. Here applied to library and main (change as needed).
set(PROJECTS
    ${MAIN_APP_UI}
)

set_target_properties(
    ${PROJECTS}
      PROPERTIES
      CXX_STANDARD 20
      CXX_STANDARD_REQUIRED YES
      CXX_EXTENSIONS NO
)

# Set up tests (see tests/CMakeLists.txt).
add_subdirectory(tests)
