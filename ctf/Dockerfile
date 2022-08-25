FROM ubuntu:20.04 AS base

ARG USER_NAME=moby
ARG USER_ID=31415

ARG PEDA_VERSION=1.2
ARG RADARE2_VERSION=5.7.6
ARG RCT_VERSION=d0bcd54

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN \
    ########################################################
    #
    # Activate i386 architecture
    #
    ########################################################
    dpkg --add-architecture i386; \
    apt update; \
    apt install -y \
        libc6:i386 \
        libncurses5:i386 \
        libstdc++6:i386; \
    ########################################################
    #
    # Install fundamental tools
    #
    ########################################################
    apt install -y \
        build-essential \
        git \
        httpie \
        python3 \
        python3-pip \
        sudo; \
    pip3 install -U pip; \
    ########################################################
    #
    # Add a user
    #
    ########################################################
    useradd -rm -d /home/$USER_NAME -s /bin/bash -g root -G sudo -u $USER_ID $USER_NAME; \
    echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME; \
    chmod 440 /etc/sudoers.d/$USER_NAME;

USER $USER_NAME

FROM base AS ctf

WORKDIR /home/$USER_NAME

RUN \
    ########################################################
    #
    # Install ExifTool
    #
    ########################################################
    sudo apt install -y exiftool; \
    ########################################################
    #
    # Install gdb-peda (https://github.com/longld/peda.git)
    #
    ########################################################
    sudo apt install -y gdb; \
    git clone --depth=1 -b v$PEDA_VERSION https://github.com/longld/peda.git; \
    echo "source ~/peda/peda.py" >> ~/.gdbinit; \
    ########################################################
    #
    # Install ltrace
    #
    ########################################################
    sudo apt install -y ltrace; \
    ########################################################
    #
    # Install pwntools (https://github.com/Gallopsled/pwntools)
    #
    ########################################################
    pip3 install pwntools; \
    ########################################################
    #
    # Install radare2 (https://github.com/radareorg/radare2)
    #
    ########################################################
    git clone --depth=1 -b $RADARE2_VERSION https://github.com/radareorg/radare2; \
    sudo radare2/sys/install.sh; \
    ########################################################
    #
    # Install RSA CTF Tool (https://github.com/Ganapati/RsaCtfTool)
    #
    ########################################################
    sudo apt install -y \
        libgmp3-dev \
        libmpc-dev; \
    git clone --depth=1 -b $RSA_CTF_TOOL_VERSION https://github.com/Ganapati/RsaCtfTool.git; \
    cd RsaCtfTool; \
        pip3 install -r "requirements.txt"; \
    cd ..; \
    ########################################################
    #
    # Install sagemath
    #
    ########################################################
    sudo apt install -y sagemath; \
    ########################################################
    #
    # Install strace
    #
    ########################################################
    sudo apt install -y strace;

FROM ctf AS ship

RUN \
    ########################################################
    #
    # Clean waste
    #
    ########################################################
    sudo apt clean; \
    sudo rm -rf /var/lib/apt/lists/*;

SHELL ["bash", "-l"]
