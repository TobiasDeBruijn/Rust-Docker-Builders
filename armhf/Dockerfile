FROM ubuntu:xenial
ENV DEBIAN_FRONTEND=noninteractive

# Change APT depos
RUN sed -i 's|deb http://archive.ubuntu.com/ubuntu/|deb [arch=amd64] http://archive.ubuntu.com/ubuntu/|' /etc/apt/sources.list
RUN sed -i 's|deb http://security.ubuntu.com/ubuntu|deb [arch=amd64] http://security.ubuntu.com/ubuntu|' /etc/apt/sources.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ubuntu-ports xenial main restricted" >> /etc/apt/sources.list.d/arm.list 
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ubuntu-ports xenial-updates main restricted" >> /etc/apt/sources.list.d/arm.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ubuntu-ports xenial universe" >> /etc/apt/sources.list.d/arm.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ubuntu-ports xenial-updates universe" >> /etc/apt/sources.list.d/arm.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ubuntu-ports xenial multiverse"  >> /etc/apt/sources.list.d/arm.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ubuntu-ports xenial-updates multiverse" >> /etc/apt/sources.list.d/arm.list
RUN echo "deb [arch=arm64,armhf] http://ports.ubuntu.com/ubuntu-ports xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/arm.list
        

# add arm32 arch
RUN dpkg --add-architecture armhf

RUN apt update -y && apt install -y \
    gcc \
    curl \
    wget \
    libssl-dev \
    libudev-dev \
    pkg-config \
    gcc-arm-linux-gnueabihf \
    libssl-dev:armhf \
    libudev-dev:armhf 

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN ln -s ${HOME}/.cargo/bin/* /usr/local/bin/
RUN rustup toolchain install nightly
RUN rustup target add arm-unknown-linux-gnueabihf
RUN rustup target add arm-unknown-linux-gnueabihf --toolchain nightly

COPY cargo_config /root/.cargo/config

ENV PKG_CONFIG_SYSROOT_DIR=/usr/lib/arm-linux-gnueabihf/

COPY ./build.sh /build.sh
RUN chmod +x /build.sh

ENTRYPOINT ["/build.sh"]