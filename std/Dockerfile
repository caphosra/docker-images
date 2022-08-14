FROM ubuntu:20.04

ARG username=moby
ARG userid=314
ARG password=moby

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

RUN \
    ########################################################
    #
    # Install fundamental tools
    #
    ########################################################
    apt update; \
    apt upgrade -y; \
    apt install -y \
        build-essential \
        git \
        python3 \
        python3-pip \
        sudo; \
    pip3 install -U pip; \
    ########################################################
    #
    # Add a user
    #
    ########################################################
    useradd -rm -d /home/$username -s /bin/bash -g root -G sudo -u $userid $username; \
    echo "root:$password" | chpasswd; \
    echo "$username:$password" | chpasswd; \
    cd /home/$username; \
    ########################################################
    #
    # Install httpie (https://github.com/httpie/httpie)
    #
    ########################################################
    apt install -y httpie; \
    ########################################################
    #
    # Clean waste
    #
    ########################################################
    apt clean; \
    rm -rf /var/lib/apt/lists/*;

USER $username
SHELL ["bash", "-l"]
