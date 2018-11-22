cmake_minimum_required(VERSION 2.8)

set(LIB_ARCH_NAME x64-ubuntu18-gcc)
set(THIRD_PARTY_ROOT /home/hsyuan/work/third_party)

add_definitions(-DMS_LITTLE_ENDIAN=1)
    
include_directories(../${LIB_ARCH_NAME}/include
        ${THIRD_PARTY_ROOT}/jsoncpp/${LIB_ARCH_NAME}/include
        ${THIRD_PARTY_ROOT}/libsrtp/${LIB_ARCH_NAME}/include
        ${THIRD_PARTY_ROOT}/libuv/${LIB_ARCH_NAME}/include
        ${THIRD_PARTY_ROOT}/openssl/${LIB_ARCH_NAME}/include
        )

link_directories(${CMAKE_SOURCE_DIR}/../${LIB_ARCH_NAME}/lib)


add_executable(test main.cpp)


target_link_libraries(test mediasoup-worker srtp openssl)
