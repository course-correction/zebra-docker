FROM ubuntu:eoan

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt update -qq && apt install --yes -qq \
  wget \
  gnupg2
  
RUN echo 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-9 main' >> /etc/apt/sources.list
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -


RUN apt update -qq && apt install --yes -qq \
    build-essential \
    cmake \
    clang-9 \
    lld-9 \
    llvm-9 \
    libc++1-9 \
    libc++-9-dev \
    libc++abi-9-dev \
    qttools5-dev \
    qtbase5-dev \
    qtbase5-dev-tools \
    python3 \
    python3-pip \
    xvfb \
    libgl1-mesa-dev \
    doxygen \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*
 
RUN pip3 install gcovr

RUN update-alternatives --remove-all cc
RUN update-alternatives --remove-all c++

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-9 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-9 100 \
        --slave   /usr/bin/ld ld /usr/bin/lld-9

CMD bin/bash
