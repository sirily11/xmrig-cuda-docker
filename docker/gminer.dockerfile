ARG CUDA_VERSION=10.2
ARG BUILD_FLAVOR=devel
ARG RUN_FLAVOR=base
ARG DISTRO=ubuntu18.04

FROM nvidia/cuda:${CUDA_VERSION}-${BUILD_FLAVOR}-${DISTRO}
WORKDIR /usr/local/bin
RUN apt-get update
RUN apt-get -qq -y install curl
RUN apt install -y wget
RUN apt install -y libpci-dev
RUN apt install -y unzip
RUN wget https://github.com/develsoftware/GMinerRelease/releases/download/2.54/gminer_2_54_linux64.tar.xz
RUN tar Jxvf gminer_2_54_linux64.tar.xz
ENTRYPOINT ["/bin/bash"]