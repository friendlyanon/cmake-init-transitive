if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/transitive CACHE PATH "")
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package transitive)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT transitive_Development
)

install(
    TARGETS transitive_transitive
    EXPORT transitiveTargets
    RUNTIME #
    COMPONENT transitive_Runtime
    LIBRARY #
    COMPONENT transitive_Runtime
    NAMELINK_COMPONENT transitive_Development
    ARCHIVE #
    COMPONENT transitive_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

configure_file(cmake/install-config.cmake.in "${package}Config.cmake" @ONLY)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    transitive_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(transitive_INSTALL_CMAKEDIR)

install(
    FILES
    "${PROJECT_BINARY_DIR}/${package}Config.cmake"
    "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${transitive_INSTALL_CMAKEDIR}"
    COMPONENT transitive_Development
)

install(
    EXPORT transitiveTargets
    NAMESPACE transitive::
    DESTINATION "${transitive_INSTALL_CMAKEDIR}"
    COMPONENT transitive_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
