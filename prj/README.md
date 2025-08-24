# [DummyName] Purpose

C++ class [DummyName] for profiling of the static library basic code.
With sample, comments and unit tests

*code conforms [cppLib] demands* (Comments; Unit Tests; Samples)

# Table of Contents
  * [Main include file](#main-include-file)
  * [Samples of usage](#samples-of-usage)
  * [Unit Tests Execution](#unit-tests-execution)
  * [How to include into a project](#how-to-include-into-a-project)

## Main include file
[dummyname.h]

## Samples of usage

|**See [samples.md]**|
|--|

## Unit Tests Execution

* Open CMakeLists.txt in the tests/unit folder as separate project
* build (see *NOTE:* below)
* execute just built `./testdummyname`

***NOTE:*** it is possible to build unit tests locally
  - [rebuild.cmd] for Windows
  - [rebuild.sh] for Linux and Mac OS

## How to include into a project

1. Include in CMakeLists.txt
```cmake
##get dummyname
include(FetchContent)
FetchContent_Declare(dummyname
        GIT_REPOSITORY https://github.com/outer/dummyname
        GIT_TAG stableVersion)
FetchContent_MakeAvailable(dummyname)
if(NOT dummyname_POPULATED)
    FetchContent_Populate(dummyname)
    add_subdirectory(${dummyname_SOURCE_DIR} ${dummyname_BUILD_DIR})
endif()
include_directories(${dummyname_SOURCE_DIR})

```
2. Add in CMakeLists.txt

    1. for your executable `dummyname`
    ```cmake
    # Link dummyname to the executable project
    target_link_libraries(${PROJECT_NAME} dummyname)
    ```

    2. for your library `dummyname`

    ```cmake
    # Link dummyname to MyLibrary
    target_link_libraries(MyLibrary PUBLIC dummyname)
    ```
3. In the C++ code - see [Samples of usage][samples.md]


[Home](#dummyname-purpose)

[cppLib]:https://github.com/zproksi/cppLibStruct

[dummyname]:./dummyname.h

[samples.md]:./samples.md
[dummyname.h]:./dummyname.h
[dummyname.cpp]:./dummyname.cpp
[rebuild.cmd]:./tests/unit/rebuild.cmd
[rebuild.sh]:./tests/unit/rebuild.sh
