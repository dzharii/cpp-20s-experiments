#!/bin/env bash
cmake -B build -S . -DCMAKE_BUILD_TYPE=Release && cmake --build build -j --config Release