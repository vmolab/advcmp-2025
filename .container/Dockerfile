# Dockerfile for practicing LLVM
# VMO Lab., 2024

# Versions
ARG UBUNTU_VERSION="noble"
FROM ubuntu:${UBUNTU_VERSION}
ARG UBUNTU_VERSION
ARG LLVM_VERSION=19

ENV TERM=xterm-256color
ARG UID=1000
ARG GID=1000

RUN apt update
RUN apt upgrade -y

# Essentials
RUN apt install -y \
    sudo \
    software-properties-common \
    vim

# Dependencies
RUN apt install -y \
    build-essential \
    net-tools \
    openssh-server \
    openssh-client \
    cmake \
    ninja-build \
    ccache \
    zlib1g \
    git \
    wget

# Add llvm-apt archive.
RUN printf "deb http://apt.llvm.org/${UBUNTU_VERSION}/ llvm-toolchain-${UBUNTU_VERSION} main \
            deb-src http://apt.llvm.org/${UBUNTU_VERSION}/ llvm-toolchain-${UBUNTU_VERSION} main" \
            > /etc/apt/sources.list.d/llvm.list
RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc

RUN apt update

# Install LLVM
RUN apt install -y \
    libllvm${LLVM_VERSION} \
    llvm-${LLVM_VERSION} \
    llvm-${LLVM_VERSION}-dev \
    lld-${LLVM_VERSION} \
    lldb-${LLVM_VERSION} \
    clang-${LLVM_VERSION}

COPY script/update-alternatives-llvm.sh /home/ubuntu/update-alternatives-llvm.sh
RUN chmod +x /home/ubuntu/update-alternatives-llvm.sh
RUN /bin/bash -c "/home/ubuntu/update-alternatives-llvm.sh ${LLVM_VERSION} 0"
RUN rm /home/ubuntu/update-alternatives-llvm.sh

# Auxiliary
RUN apt install -y \
    zlib1g-dev \
    libcurl4-openssl-dev \
    libzstd-dev

# Root P/W: ubuntu
RUN echo "root:ubuntu" | chpasswd

# ubuntu P/W: ubuntu
# RUN groupadd -g $GID -o ubuntu
# RUN useradd -m -u $UID -g $GID -s /bin/bash ubuntu && \
#     usermod -aG sudo ubuntu
# RUN ps -u ubuntu
RUN usermod -u $UID ubuntu
RUN groupmod -g $GID ubuntu
RUN echo "ubuntu:ubuntu" | chpasswd
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN sudo -k
RUN chown -R ubuntu /home/ubuntu/

USER ubuntu

WORKDIR /home/ubuntu
ENTRYPOINT ["tail", "-f", "/dev/null"]
EXPOSE 22