#!/bin/bash
UBUNTU=${UBUNTU:-latest}
if [ -z "$XMAKE" ]; then
    LATEST="-t diguser/xmake-mingw-w64:latest"
    XMAKE=$(curl -fs https://api.github.com/repos/xmake-io/xmake/releases/latest | grep -E "\"tag_name\":\s?\"v[0-9.]+\"" | grep -Eo "[0-9.]+")
fi
echo "Build docker with ubuntu:$UBUNTU and xmake:$XMAKE"
docker build \
    -t diguser/xmake-mingw-w64:$XMAKE \
    $LATEST \
    --build-arg ubuntu=$UBUNTU \
    --build-arg xmake=$XMAKE \
    --compress \
    .