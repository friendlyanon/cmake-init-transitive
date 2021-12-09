include(cmake/folders.cmake)

include(CTest)
if(BUILD_TESTING)
  add_subdirectory(test)
endif()

add_folders(Project)
