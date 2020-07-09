FROM debian:buster

LABEL maintainer="benjaminjeliot@gmail.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    make \
    wget \
    cmake \
    python3 \
    python3-pytest \
    googletest \
    libopenmpi-dev \
    libhdf5-openmpi-103 \
 && rm -rf /var/lib/apt/lists/*

# Build and install Google Test
RUN mkdir gtest-build \
 && cd gtest-build \
 && cmake \
    -DBUILD_GTEST:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr/local \
    /usr/src/googletest \
 && cmake --build . \
 && cmake --build . --target install \
 && cd .. \
 && rm -rf gtest-build

