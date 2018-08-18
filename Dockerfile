FROM ubuntu:latest
MAINTAINER [Kristian Gregorius Hustad <krihus@ifi.uio.no>]

# Set up locales properly
RUN apt-get update && \
    apt-get install --yes --no-install-recommends locales && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Use bash as default shell, rather than sh
ENV SHELL /bin/bash



RUN apt-get update && \
    apt-get install -y  wget \
                        curl \
                        tar \
                        less \
                        vim \
                        libgetopt-long-descriptive-perl \
                        python-pygments && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/lists/*

WORKDIR /root

COPY texlive.profile /root
RUN curl -sL https://ctan.uib.no/systems/texlive/tlnet/install-tl-unx.tar.gz | tar xf - && \
    cd install-tl-20* && \
    ./install-tl -profile ../texlive.profile && \
    cd .. && \
    rm -rf install-tl-*

WORKDIR /home
