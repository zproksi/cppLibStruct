cmake_minimum_required(VERSION 3.19)

project(dummynamelib)

set(SOURCE_FILES
    dummyname.cpp
)
set(HEADER_FILES
    dummyname.h
)

#create static library
add_library(dummyname STATIC ${SOURCE_FILES} ${HEADER_FILES})

#optionally
target_include_directories(dummyname PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

#optionally
set(dummyname_VERSION 1.0.1)
