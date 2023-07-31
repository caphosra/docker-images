FROM build AS ship

RUN \
    set -eux; \
    ########################################################
    #
    # Clean waste
    #
    ########################################################
    sudo apt clean; \
    sudo rm -rf /var/lib/apt/lists/*;

ENV DEBIAN_FRONTEND=newt

SHELL ["bash", "-l"]
