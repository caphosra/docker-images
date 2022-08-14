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
    # Add a user
    #
    ########################################################
    useradd -rm -d /home/$username -s /bin/bash -g root -G sudo -u $userid $username; \
    echo "root:$password" | chpasswd; \
    echo "$username:$password" | chpasswd; \
    cd /home/$username; \
    ########################################################
    #
    # Install ExifTool
    #
    ########################################################
    apt install -y exiftool; \
    ########################################################
    #
    # Install gdb-peda (https://github.com/longld/peda.git)
    #
    ########################################################
    apt install -y gdb; \
    git clone https://github.com/longld/peda.git; \
    echo "source ~/peda/peda.py" >> .gdbinit; \
    ########################################################
    #
    # Install httpie (https://github.com/httpie/httpie)
    #
    ########################################################
    apt install -y httpie; \
    ########################################################
    #
    # Install ltrace
    #
    ########################################################
    apt install -y ltrace; \
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
    git clone --depth=1 https://github.com/radareorg/radare2; \
    radare2/sys/install.sh; \
    ########################################################
    #
    # Install RSA CTF Tool (https://github.com/Ganapati/RsaCtfTool)
    #
    ########################################################
    apt install -y \
        libgmp3-dev \
        libmpc-dev; \
    git clone https://github.com/Ganapati/RsaCtfTool.git; \
    cd RsaCtfTool; \
    git checkout 08e53aa9e1de8e1cb17f160bf60e7bab8d507fe5; \
    pip3 install -r "requirements.txt"; \
    cd ..; \
    ########################################################
    #
    # Install sagemath
    #
    ########################################################
    apt install -y sagemath; \
    ########################################################
    #
    # Install strace
    #
    ########################################################
    apt install -y strace; \
    ########################################################
    #
    # Clean waste
    #
    ########################################################
    apt remove -y --purge \
        git; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*;

USER $username
SHELL ["bash", "-l"]
