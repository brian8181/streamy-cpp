# File Name:  streamy/src/CMakeLists.txt
# Build Date: Mon Mar  4 09:11:39 AM CST 2024
# Version:    0.1.0

cmake_minimum_required(VERSION 3.2)
project(streamy)

#set(BUILD_SHARED_LIBS YES)

add_executable(index.cgi
    streamy.cpp
    index.cpp
    utility.cpp
)

add_executable(index2.cgi
    streamy.cpp
    index2.cpp
    utility.cpp
)

add_executable(index3.cgi
    streamy.cpp
    index3.cpp
    utility.cpp
)


add_library(streamyso SHARED
    streamy.cpp
)


add_library(streamya STATIC
    streamy.cpp
)


#[=[
    # Add Library
    add_library(targetName [STATIC | SHARED | MODULE]
    [EXCLUDE_FROM_ALL]
    source1 [source2 ...]
)
]=]