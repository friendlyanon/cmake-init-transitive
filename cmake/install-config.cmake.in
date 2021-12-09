include(CMakeFindDependencyMacro)
find_dependency(json-c)

if(NOT "@BUILD_SHARED_LIBS@")
  find_dependency(fmt)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/transitiveTargets.cmake")
