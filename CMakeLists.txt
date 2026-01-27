# File Name:  CMakeLists.txt
# Build Date: Sat, Nov 29, 2025  1:20:21 AM
# Version:    0.1.1

cmake_minimum_required(VERSION 3.28.3)
# We don't use the C++ compiler, so don't let project()
# test for it in case the platform doesn't have one
project(streamy VERSION 0.1.0
                DESCRIPTION "Very nice project"
                LANGUAGES CXX)


if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    # Enable C++11 for GNU compilers
    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "CYGWIN")
    message(STATUS "Building under Cygwin, defining CYGWIN macro")
    add_definitions(-DCYGWIN)
endif()

# Find Bison package
find_package(BISON REQUIRED)
if(NOT BISON_FOUND)
    message(FATAL_ERROR "Bison not found")
endif()

# Now you can use BISON_TARGET
BISON_TARGET(MyParser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.cpp
             DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.h)

# Rest of your original code
find_package(FLEX)
FLEX_TARGET(MyScanner lex.l ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.c)

# Find required packages
find_package(fmt REQUIRED)

if(NOT fmt_FOUND)
    message(FATAL_ERROR "fmt not found")
endif()

find_package(PkgConfig REQUIRED)
pkg_check_modules(CPPUNIT REQUIRED cppunit)

if(NOT CPPUNIT_FOUND)
    message(FATAL_ERROR "CPPUnit not found")
endif()

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/src)

# Add source files
set(SOURCES
    src/streamy.cpp
    src/fileio.cpp
    cbuild/lex.yy.c
    cbuild/parser.tab.c
)

# Create library from sources
#add_library(${PROJECT_NAME}_lib ${SOURCES})

add_executable(${PROJECT_NAME} ${SOURCES})

# Enable testing
enable_testing()

# Add tests subdirectory
#add_subdirectory(tests)

find_package(PkgConfig REQUIRED)
pkg_check_modules(CPPUNIT REQUIRED cppunit)

if(NOT CPPUNIT_FOUND)
    message(FATAL_ERROR "CPPUnit not found")
endif()
