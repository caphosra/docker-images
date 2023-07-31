##### INSERT! ./non-root/base

FROM base AS build

ARG CABAL_VERSION=3.10.1.0
ARG GHC_VERSION=9.4.5
ARG HLS_VERSION=2.0.0.0
ARG STACK_VERSION=2.11.1

ENV PATH="/home/$USER_NAME/.cabal/bin:/home/$USER_NAME/.ghcup/bin:$PATH"
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
ENV BOOTSTRAP_HASKELL_MINIMAL=1

RUN \
    set -eux; \
    ########################################################
    #
    # Install GHCup
    #
    ########################################################
    sudo apt install -y \
        curl \
        libffi-dev \
        libffi7 \
        libgmp-dev \
        libgmp10 \
        libncurses-dev \
        libncurses5 \
        libtinfo5; \
    http --ignore-stdin https://get-ghcup.haskell.org | sh; \
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
    ghcup set hls $HLS_VERSION; \
    ########################################################
    #
    # Install fourmolu
    #
    ########################################################
    stack install fourmolu; \
    sudo mv ~/.local/bin/fourmolu /usr/local/bin;

##### INSERT! ./non-root/clean
