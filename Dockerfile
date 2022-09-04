# syntax=docker/dockerfile:1.3
ARG from

FROM ubuntu:20.04 AS dev

RUN test -d ${INSTALL_PREFIX} || mkdir ${INSTALL_PREFIX}

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential libsdl2-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean -y --no-install-recommends && \
    apt-get autoclean -y --no-install-recommends

ENTRYPOINT /bin/bash


FROM dev AS builder

ENV INSTALL_PREFIX=/usr

# Build the ioq3 source
RUN --mount=type=bind,rw,target=/ioq3-src,source=. \
    cd /ioq3-src \
    && make -j$(nproc) \
    && make install
