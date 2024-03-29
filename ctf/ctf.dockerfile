#
# The main idea of this docker file is from https://github.com/iphoneintosh/kali-docker.
#
FROM kalilinux/kali-rolling:latest AS base

ARG USER_NAME=kali
ARG USER_ID=31415
ARG KALI_DESKTOP=xfce
ARG PEDA_VERSION=1.2
ARG RCT_VERSION=be982b3

ENV DEBIAN_FRONTEND noninteractive
ENV LC_CTYPE=C.UTF-8
ENV USER=$USER_NAME

ENV VNC_EXPOSE=0
ENV VNC_PORT=5900
ENV VNC_DISPLAY=1920x1080
ENV VNC_DEPTH=16
ENV VNC_PASSWORD=password
ENV NOVNC_PORT=8080

RUN \
    set -eux; \
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
        kali-linux-default \
        kali-desktop-$KALI_DESKTOP \
        tightvncserver \
        dbus \
        dbus-x11 \
        novnc \
        net-tools; \
    ########################################################
    #
    # Add a user
    #
    ########################################################
    useradd -rm -d /home/$USER_NAME -s /bin/bash -g root -G sudo -u $USER_ID $USER_NAME; \
    echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME; \
    chmod 440 /etc/sudoers.d/$USER_NAME;

USER $USER_NAME

FROM base AS build

WORKDIR /home/$USER_NAME
COPY ./ctf/launch.sh /home/$USER_NAME/launch.sh

RUN \
    set -eux; \
    ########################################################
    #
    # Install pwntools (https://github.com/Gallopsled/pwntools)
    #
    ########################################################
    sudo apt install -y \
        python3 \
        python3-pip \
        python3-dev \
        git \
        libssl-dev \
        libffi-dev \
        build-essential; \
    python3 -m pip install --upgrade pip; \
    python3 -m pip install --upgrade pwntools; \
    ########################################################
    #
    # Install ptrlib (https://github.com/ptr-yudai/ptrlib)
    #
    ########################################################
    pip install ptrlib; \
    ########################################################
    #
    # Install pwndbg (https://github.com/pwndbg/pwndbg)
    #
    ########################################################
    git clone https://github.com/pwndbg/pwndbg; \
    cd pwndbg; \
        ./setup.sh; \
    cd ..; \
    ########################################################
    #
    # Install RSA CTF Tool (https://github.com/Ganapati/RsaCtfTool)
    #
    ########################################################
    sudo apt install -y \
        libgmp3-dev \
        libmpc-dev; \
    git clone https://github.com/Ganapati/RsaCtfTool.git; \
    cd RsaCtfTool; \
        git checkout $RCT_VERSION; \
        pip install -r "requirements.txt"; \
    cd ..; \
    ########################################################
    #
    # Add entrypoint
    #
    ########################################################
    sudo chmod +x /home/$USER_NAME/launch.sh;

##### INSERT! ./non-root/clean
