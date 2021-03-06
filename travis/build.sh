#!/bin/sh
set -e

if [ "$BUILD_TYPE" != "cmake" -a "$BUILD_TYPE" != "valgrind" ]; then
    ./buildconf
    $SCAN_WRAP ./configure --disable-symbol-hiding --enable-expose-statics --enable-maintainer-mode --enable-debug $CONFIG_OPTS
    $SCAN_WRAP make
else
    # Use cmake for valgrind to prevent libtool script wrapping of tests that interfere with valgrind
    mkdir cmakebld
    cd cmakebld
    cmake -DCMAKE_BUILD_TYPE=DEBUG -DCARES_STATIC=ON -DCARES_STATIC_PIC=ON -DCARES_BUILD_TESTS=ON ..
    make
fi
