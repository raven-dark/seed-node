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

COPY raven-dark-0.2.0-rc1.tar.gz /

RUN tar -xzvf raven-dark-0.2.0-rc1.tar.gz -C /ravendark

RUN chmod +x /ravendark/ravendarkd
RUN chmod +x /ravendark/ravendark-cli

RUN ln -sf /ravendark/ravendarkd /usr/bin/ravendarkd
RUN ln -sf  /ravendark/ravendark-cli /usr/bin/ravendark-cli

RUN apt-get autoclean && \
  apt-get autoremove -y

RUN mkdir -p /root/data

VOLUME /root/data

# sentinel
RUN apt-get install python3-pip -y;
RUN pip3 install virtualenv;
RUN cd ~ && \
  git clone https://github.com/raven-dark/sentinel.git && cd sentinel && \
  virtualenv ./venv && \
  ./venv/bin/pip install -r requirements.txt && \
  echo "* * * * *    root    cd /root/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> /etc/crontab

#6666 is p2p
EXPOSE 6666

CMD ravendarkd
