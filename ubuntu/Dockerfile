FROM ubuntu:20.04 AS base

ARG USER_NAME=moby
ARG USER_ID=31415

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN \
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

FROM base AS ship

RUN \
    ########################################################
    #
    # Clean waste
    #
    ########################################################
    sudo apt clean; \
    sudo rm -rf /var/lib/apt/lists/*;

SHELL ["bash", "-l"]
