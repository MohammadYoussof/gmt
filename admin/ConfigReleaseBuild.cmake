#
# Use this file as ConfigUser.cmake when building the release
# Make sure GMT_GSHHG_SOURCE and GMT_DCW_SOURCE are defined in
# your environment and pointing to the latest releases.
# Unless you are Paul, make sure GMT_REPO_DIR is defined in
# your environment.
#
#-------------------------------------------------------------
set (CMAKE_BUILD_TYPE Release)
if ($ENV{USER} STREQUAL "pwessel") 
	set (CMAKE_INSTALL_PREFIX "gmt-${GMT_PACKAGE_VERSION}")
else ()
	set (CMAKE_INSTALL_PREFIX "$ENV{GMT_REPO_DIR}/build/gmt-${GMT_PACKAGE_VERSION}")
endif()
set (GSHHG_ROOT "$ENV{GMT_GSHHG_SOURCE}")
set (DCW_ROOT "$ENV{GMT_DCW_SOURCE}")

#set (GMT_USE_THREADS TRUE)
set (GMT_ENABLE_OPENMP TRUE)

# recommended even for release build
set (CMAKE_C_FLAGS "-Wall -Wdeclaration-after-statement ${CMAKE_C_FLAGS}")
# extra warnings
set (CMAKE_C_FLAGS "-Wextra ${CMAKE_C_FLAGS}")
# Include all the external executables and shared libraries
# The add_macOS_cpack.txt is created by build-release.sh and placed in build
if (APPLE)
	# Try to codesign the Apple Bundle application if Paul or Meghan is building it
	if (($ENV{USER} STREQUAL "pwessel") OR ($ENV{USER} STREQUAL "meghanj") AND GMT_PUBLIC_RELEASE)
		set (CPACK_BUNDLE_APPLE_CERT_APP "Developer ID Application: University of Hawaii (B8Y298FMLQ)")
		set (CPACK_BUNDLE_APPLE_CODESIGN_PARAMETER "--deep -f --options runtime")
	endif ()
	set (EXTRA_INCLUDE_EXES "${CMAKE_BINARY_DIR}/add_macOS_cpack.txt")
endif (APPLE)
