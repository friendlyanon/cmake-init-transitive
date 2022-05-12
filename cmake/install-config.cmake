include(CMakeFindDependencyMacro)
find_dependency(json-c)
find_dependency(fmt)

include("${CMAKE_CURRENT_LIST_DIR}/transitiveTargets.cmake")
