ARG CUDA_VERSION=11.3.0
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
RUN wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.28/lolMiner_v1.28a_Lin64.tar.gz
RUN tar zxvf lolMiner_v1.28a_Lin64.tar.gz
ENTRYPOINT ["/bin/bash"]