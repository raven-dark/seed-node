FROM ubuntu:trusty

RUN apt-get update && apt-get install -y \
  libzmq3-dev \
  libzmq3-dbg \
  libzmq3 \
  software-properties-common \
  curl \
  build-essential \
  libssl-dev \
  wget \
  libtool \
  autotools-dev \
  automake \
  pkg-config \
  libssl-dev \
  libevent-dev \
  bsdmainutils \
  git \
  vim

RUN add-apt-repository ppa:bitcoin/bitcoin -y
RUN apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev

RUN apt-get install -y \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-chrono-dev \
  libboost-program-options-dev \
  libboost-test-dev \
  libboost-thread-dev

RUN mkdir /ravendark

RUN wget -qO- https://github.com/raven-dark/raven-dark/releases/download/0.3.1/ravendark-0.3.1-ubuntu-14.04.tar.gz | tar xvz -C /ravendark

RUN chmod +x /ravendark/ravendarkd
RUN chmod +x /ravendark/ravendark-cli

RUN ln -sf /ravendark/ravendarkd /usr/bin/ravendarkd
RUN ln -sf  /ravendark/ravendark-cli /usr/bin/ravendark-cli

RUN apt-get autoclean && \
  apt-get autoremove -y

RUN mkdir -p /root/data

COPY ravendark.conf /root/data/ravendark.conf

VOLUME /root/data

#6666 is p2p
EXPOSE 6666

CMD ravendarkd -datadir=/root/data
