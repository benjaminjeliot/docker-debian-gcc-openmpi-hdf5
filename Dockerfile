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
    libopenmpi3-dev \
    libhdf5-openmpi-103 \
 && rm -rf /var/lib/apt/lists/*

