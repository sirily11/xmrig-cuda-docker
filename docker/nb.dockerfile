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
RUN wget https://github.com/RavenCommunity/kawpowminer/releases/download/1.2.3/kawpowminer-ubuntu18-1.2.3.zip
RUN unzip kawpowminer-ubuntu18-1.2.3.zip
ENTRYPOINT ["/bin/bash"]