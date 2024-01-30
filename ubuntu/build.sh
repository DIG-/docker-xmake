#!/bin/bash
UBUNTU=${UBUNTU:-latest}
XMAKE=${XMAKE:-2.8.6}
docker build \
    -t diguser/xmake-ubuntu:$XMAKE \
    --build-arg ubuntu=$UBUNTU \
    --build-arg xmake=$XMAKE \
    --compress \
    .