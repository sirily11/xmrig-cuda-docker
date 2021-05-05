ARG CUDA_VERSION=10.0
ARG BUILD_FLAVOR=devel
ARG RUN_FLAVOR=base
ARG DISTRO=ubuntu18.04

FROM nvidia/cuda:${CUDA_VERSION}-${BUILD_FLAVOR}-${DISTRO}
WORKDIR /usr/local/bin
RUN apt-get update
RUN apt-get -qq -y install curl
RUN apt install -y wget
RUN apt install -y libpci-dev
RUN wget https://github.com/PhoenixMinerDevTeam/PhoenixMiner/releases/download/5.5c/PhoenixMiner_5.5c_Linux.tar.gz
RUN tar xzfv PhoenixMiner_5.5c_Linux.tar.gz
ENTRYPOINT ["/bin/bash"]