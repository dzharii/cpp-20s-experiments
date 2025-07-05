@echo off
set BUILD_DIR=build-debug
cmake -B %BUILD_DIR% -S . -DCMAKE_BUILD_TYPE=Debug && ^
cmake --build %BUILD_DIR% -j --config Debug && ^
%BUILD_DIR%\bin\Debug\unit_tests.exe && ^
%BUILD_DIR%\bin\Debug\unit_tests.exe --list-test-cases