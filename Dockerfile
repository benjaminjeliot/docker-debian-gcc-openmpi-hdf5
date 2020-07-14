FROM debian:buster

LABEL maintainer="benjaminjeliot@gmail.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    gfortran \
    make \
    ca-certificates \
    wget \
    cmake \
    python3 \
    python3-pip \
    python3-pytest \
    googletest \
    libopenmpi-dev \
    libhdf5-openmpi-dev \
 && rm -rf /var/lib/apt/lists/*

# Install cpplint
RUN pip3 install cpplint

# Build and install Google Test
RUN mkdir gtest-build \
 && cd gtest-build \
 && export CXX=g++ CC=gcc \
 && cmake \
    -DBUILD_GTEST:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr/local \
    /usr/src/googletest \
 && cmake --build . \
 && cmake --build . --target install \
 && cd .. \
 && rm -rf gtest-build

# Build and install TyphonIO
RUN wget https://github.com/UK-MAC/typhonio/archive/v1.6_CMake.tar.gz \
 && tar -xf v1.6_CMake.tar.gz \
 && mkdir typhonio-build \
 && cd typhonio-build \
 && export CXX=g++ CC=gcc \
 && cmake \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr/local \
    ../typhonio-1.6_CMake \
 && cmake --build . \
 && cmake --build . --target install \
 && cd .. \
 && rm -rf v1.6_CMake.tar.gz typhonio-1.6_CMake typhonio-build

