cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    transitive
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    transitive_transitive
    source/transitive.cpp
)
add_library(transitive::transitive ALIAS transitive_transitive)

include(GenerateExportHeader)
generate_export_header(
    transitive_transitive
    BASE_NAME transitive
    EXPORT_FILE_NAME export/transitive/transitive_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(transitive_transitive PUBLIC TRANSITIVE_STATIC_DEFINE)
endif()

set_target_properties(
    transitive_transitive PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME transitive
    OUTPUT_NAME transitive
)

target_include_directories(
    transitive_transitive ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    transitive_transitive SYSTEM
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(transitive_transitive PUBLIC cxx_std_17)

find_package(json-c REQUIRED)
find_package(fmt REQUIRED)
target_link_libraries(
    transitive_transitive
    PUBLIC json-c::json-c
    PRIVATE fmt::fmt
)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT transitive_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of transitive"
  )
endif()

include(cmake/dev-mode.cmake)
