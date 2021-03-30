# CMakeList.txt : CMake project for CC4102, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

project ("CC4102")

# Add source to this project's executable.
add_executable (CC4102 "CC4102.cpp" "CC4102.h" "textSearch.cpp" "textSearch.h")

# TODO: Add tests and install targets if needed.
