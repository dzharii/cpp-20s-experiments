@echo off
set BUILD_DIR=build-release
cmake -B %BUILD_DIR% -S . -DCMAKE_BUILD_TYPE=Release && ^
cmake --build %BUILD_DIR% -j --config Release && ^
%BUILD_DIR%\bin\Release\unit_tests.exe && ^
%BUILD_DIR%\bin\Release\unit_tests.exe --list-test-cases