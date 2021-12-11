add_executable(test_talk talker.cc)
target_link_libraries(test_talk
        PocoFoundation
        fastrtps
        glog
        cyber_mine)