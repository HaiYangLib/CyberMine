cmake_minimum_required(VERSION 3.5)

project(cyber_mine)

# clang-8
set(CMAKE_C_COMPILER /usr/bin/clang-8)
set(CMAKE_CXX_COMPILER /usr/bin/clang++-8)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -O0 -DNDEBUG" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
message("CXX_FLAGS:${CMAKE_CXX_FLAGS}")

include_directories(${PROJECT_SOURCE_DIR})

# ======================Cyber依赖的第三方库========================
set(poco_path third_party/poco/poco-poco-1.11.1-release-c8-libstdcxx-install)
set(fast_rtps_path third_party/fast_rtps/fast_rtps-v2.4.1-c8-libstdcxx-install/usr/local)
set(glog_path third_party/glog/glog-v0.5.0-c8-libstdcxx-install)
# poco
include_directories(${poco_path}/include)
link_directories(${poco_path}/lib)
# fast_rtps
include_directories(${fast_rtps_path}/include)
link_directories(${fast_rtps_path}/lib)
# glog
include_directories(${glog_path}/include)
link_directories(${glog_path}/lib)

set(cyber_source_path "${PROJECT_SOURCE_DIR}/cyber")
file(GLOB cyber_sources
        ${cyber_source_path}/*.h
        ${cyber_source_path}/*.cc

        ${cyber_source_path}/base/*.h
        ${cyber_source_path}/base/*.cc

        ${cyber_source_path}/blocker/*.h
        ${cyber_source_path}/blocker/*.cc

        ${cyber_source_path}/class_loader/*.h
        ${cyber_source_path}/class_loader/*.cc
        ${cyber_source_path}/class_loader/utility/*.h
        ${cyber_source_path}/class_loader/utility*.cc

        ${cyber_source_path}/common/*.h
        ${cyber_source_path}/common/*.cc

        ${cyber_source_path}/component/*.h
        ${cyber_source_path}/component/*.cc

        ${cyber_source_path}/croutine/*.h
        ${cyber_source_path}/croutine/*.cc
        ${cyber_source_path}/croutine/detail/*.h
        ${cyber_source_path}/croutine/detail/*.cc

        ${cyber_source_path}/data/*.h
        ${cyber_source_path}/data/*.cc
        ${cyber_source_path}/data/fusion/*.h
        ${cyber_source_path}/data/fusion/*.cc

        ${cyber_source_path}/event/*.h
        ${cyber_source_path}/event/*.cc

        ${cyber_source_path}/io/*.h
        ${cyber_source_path}/io/*.cc

        ${cyber_source_path}/logger/*.h
        ${cyber_source_path}/logger/*.cc

        ${cyber_source_path}/mainboard/*.h
        ${cyber_source_path}/mainboard/*.cc

        ${cyber_source_path}/message/*.h
        ${cyber_source_path}/message/*.cc

        ${cyber_source_path}/node/*.h
        ${cyber_source_path}/node/*.cc

        ${cyber_source_path}/parameter/*.h
        ${cyber_source_path}/parameter/*.cc

        ${cyber_source_path}/proto/*.h
        ${cyber_source_path}/proto/*.cc

        ${cyber_source_path}/record/*.h
        ${cyber_source_path}/record/*.cc
        ${cyber_source_path}/record/file/*.h
        ${cyber_source_path}/record/file/*.cc

        ${cyber_source_path}/scheduler/*.h
        ${cyber_source_path}/scheduler/*.cc
        ${cyber_source_path}/scheduler/common/*.h
        ${cyber_source_path}/scheduler/common/*.cc
        ${cyber_source_path}/scheduler/policy/*.h
        ${cyber_source_path}/scheduler/policy/*.cc

        ${cyber_source_path}/service_discovery/*.h
        ${cyber_source_path}/service_discovery/*.cc
        ${cyber_source_path}/service_discovery/communication/*.h
        ${cyber_source_path}/service_discovery/communication/*.cc
        ${cyber_source_path}/service_discovery/container/*.h
        ${cyber_source_path}/service_discovery/container/*.cc
        ${cyber_source_path}/service_discovery/role/*.h
        ${cyber_source_path}/service_discovery/role/*.cc
        ${cyber_source_path}/service_discovery/specific_manager/*.h
        ${cyber_source_path}/service_discovery/specific_manager/*.cc

        ${cyber_source_path}/task/*.h
        ${cyber_source_path}/task/*.cc

        ${cyber_source_path}/time/*.h
        ${cyber_source_path}/time/*.cc

        ${cyber_source_path}/timer/*.h
        ${cyber_source_path}/timer/*.cc

        ${cyber_source_path}/transport/*.h
        ${cyber_source_path}/transport/*.cc
        ${cyber_source_path}/transport/common/*.h
        ${cyber_source_path}/transport/common/*.cc
        ${cyber_source_path}/transport/dispatcher/*.h
        ${cyber_source_path}/transport/dispatcher/*.cc
        ${cyber_source_path}/transport/message/*.h
        ${cyber_source_path}/transport/message/*.cc
        ${cyber_source_path}/transport/qos/*.h
        ${cyber_source_path}/transport/qos/*.cc
        ${cyber_source_path}/transport/receiver/*.h
        ${cyber_source_path}/transport/receiver/*.cc
        ${cyber_source_path}/transport/rtps/*.h
        ${cyber_source_path}/transport/rtps/*.cc
        ${cyber_source_path}/transport/shm/*.h
        ${cyber_source_path}/transport/shm/*.cc
        ${cyber_source_path}/transport/transceiver/*.h
        ${cyber_source_path}/transport/transceiver/*.cc
        ${cyber_source_path}/transport/transmitter/*.h
        ${cyber_source_path}/transport/transmitter/*.cc
        )

add_library(cyber_mine STATIC ${cyber_sources})

add_subdirectory(test)
