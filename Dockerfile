ARG CUDA_VERSION=10.0
ARG BUILD_FLAVOR=devel
ARG RUN_FLAVOR=base
ARG DISTRO=ubuntu18.04

FROM nvidia/cuda:${CUDA_VERSION}-${BUILD_FLAVOR}-${DISTRO} AS build

ENV VERSION 'v2.11.0'
ENV CMAKE_OPTS='-DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7 -DWITH_AEON=OFF -DWITH_HTTPD=OFF'

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev

RUN git clone https://github.com/xmrig/xmrig-cuda
RUN cd xmrig-cuda && mkdir build

WORKDIR xmrig-cuda/build
RUN cmake .. -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so ${CMAKE_OPTS} -DCMAKE_CXX_FLAGS=-std=c++11 && make -j8
RUN ls

FROM nvidia/cuda:${CUDA_VERSION}-${RUN_FLAVOR}-${DISTRO}

LABEL maintainer='docker@merxnet.io'

COPY --from=build /xmrig-cuda/build/libxmrig-cuda.so /usr/local/bin/libxmrig-cuda.so
RUN apt-get update
RUN apt-get -qq -y install curl
RUN apt install -y wget
RUN wget https://github.com/xmrig/xmrig/releases/download/v6.12.1/xmrig-6.12.1-linux-x64.tar.gz
RUN tar xzfv xmrig-6.12.1-linux-x64.tar.gz
RUN cp xmrig-6.12.1/xmrig /usr/local/bin/
ENTRYPOINT ["/bin/bash"]