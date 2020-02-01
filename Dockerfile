FROM ubuntu:eoan

RUN apt update -qq && apt install --yes -qq \
  wget \
  gnupg2
  
RUN echo 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-9 main' >> /etc/apt/sources.list
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -


RUN apt update -qq && apt install --yes -qq \
    build-essential \
    cmake \
    clang-9 \
    llvm-9 \
    libc++1-9 \
    libc++-9-dev \
    libc++abi-9-dev \
    qttools5-dev \
    qtbase5-dev \
    qtbase5-dev-tools \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-9 10
RUN update-alternatives --set clang++ "/usr/bin/clang++-9"

RUN update-alternatives --set c++ "/usr/bin/clang++"

CMD bin/bash
