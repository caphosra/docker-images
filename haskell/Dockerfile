FROM ubuntu:20.04 AS base

ARG USER_NAME=moby
ARG USER_ID=31415

ARG CABAL_VERSION=3.8.1.0
ARG GHC_VERSION=8.10.7
ARG HLS_VERSION=1.7.0.0
ARG STACK_VERSION=2.7.5

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN \
    ########################################################
    #
    # Install fundamental tools
    #
    ########################################################
    apt update; \
    apt install -y \
        build-essential \
        git \
        httpie \
        sudo; \
    ########################################################
    #
    # Add a user
    #
    ########################################################
    useradd -rm -d /home/$USER_NAME -s /bin/bash -g root -G sudo -u $USER_ID $USER_NAME; \
    echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME; \
    chmod 440 /etc/sudoers.d/$USER_NAME;

USER $USER_NAME

FROM base AS haskell

ENV PATH="/home/$USER_NAME/.cabal/bin:/home/$USER_NAME/.ghcup/bin:$PATH"
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
ENV BOOTSTRAP_HASKELL_MINIMAL=1

RUN \
    ########################################################
    #
    # Install GHCup
    #
    ########################################################
    sudo apt install -y \
        libffi-dev \
        libffi7 \
        libgmp-dev \
        libgmp10 \
        libncurses-dev \
        libncurses5 \
        libtinfo5; \
    http https://get-ghcup.haskell.org | sh; \
    echo "export PATH=$PATH" >> /home/$USER_NAME/.profile; \
    ########################################################
    #
    # Install GHC (The Glasgow Haskell Compiler)
    #
    ########################################################
    ghcup install ghc $GHC_VERSION; \
    ghcup set ghc $GHC_VERSION; \
    ########################################################
    #
    # Install cabal
    #
    ########################################################
    ghcup install cabal $CABAL_VERSION; \
    ghcup set cabal $CABAL_VERSION; \
    ########################################################
    #
    # Install stack
    #
    ########################################################
    ghcup install stack $STACK_VERSION; \
    ghcup set stack $STACK_VERSION; \
    ########################################################
    #
    # Install haskell-language-server
    #
    ########################################################
    ghcup install hls $HLS_VERSION; \
    ghcup set hls $HLS_VERSION;

FROM haskell AS ship

RUN \
    ########################################################
    #
    # Clean waste
    #
    ########################################################
    sudo apt clean; \
    sudo rm -rf /var/lib/apt/lists/*;

SHELL ["bash", "-l"]
