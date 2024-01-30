#!/bin/bash
UBUNTU=${UBUNTU:-latest}
XMAKE=${XMAKE:-2.8.6}
docker build \
    -t diguser/xmake-mingw-w64:$XMAKE \
    --build-arg ubuntu=$UBUNTU \
    --build-arg xmake=$XMAKE \
    --compress \
    .