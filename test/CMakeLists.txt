cmake_minimum_required(VERSION 3.14)

project(transitiveTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)
include(../cmake/windows-set-path.cmake)

if(PROJECT_IS_TOP_LEVEL)
  find_package(transitive REQUIRED)
  enable_testing()
endif()

add_executable(transitive_test source/transitive_test.cpp)
target_link_libraries(transitive_test PRIVATE transitive::transitive)
target_compile_features(transitive_test PRIVATE cxx_std_17)

add_test(NAME transitive_test COMMAND transitive_test)
windows_set_path(transitive_test transitive::transitive json-c::json-c fmt::fmt)

add_folders(Test)
