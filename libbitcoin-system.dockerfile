## USAGE: $ DOCKER_BUILDKIT=1 docker build --pull --no-cache -f libbitcoin-system.dockerfile -t libbitcoin-system .
## OR
## $ docker pull buildpack-deps
## $ docker build - <  libbitcoin-system.dockerfile
## AND
## $ docker run -it [container id]

#Maintainer: Randy McMillan (@RandyMcMillan)
#GitRepo: https://github.com/RandyMcMillan/bitcoin-core-review.git

FROM buildpack-deps:buster

RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/libbitcoin/libbitcoin/version3/install.sh
RUN chmod +x install.sh
RUN mkdir libbitcoin-system
#REF: https://github.com/libbitcoin/libbitcoin-system#build-notes-for-linux--macos
RUN echo "Take a break! Building libbitcoin-system image!"
RUN ./install.sh --prefix=/libbitcoin-system --with-icu --with-png --with-qrencode --build-icu --build-zlib --build-png --build-qrencode --build-boost --disable-shared
RUN ln -sf /libbitcoin-system/bin/* /bin/
