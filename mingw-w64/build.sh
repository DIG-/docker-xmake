#!/bin/bash
UBUNTU=${UBUNTU:-latest}
if [ -z "$XMAKE" ]; then
    XMAKE_LATEST=1
    XMAKE=$(curl -fs https://api.github.com/repos/xmake-io/xmake/releases/latest | grep -E "\"tag_name\":\s?\"v[0-9.]+\"" | grep -Eo "[0-9.]+")
else
    XMAKE_LATEST=$(curl -fs https://api.github.com/repos/xmake-io/xmake/releases/latest | grep -E "\"tag_name\":\s?\"v[0-9.]+\"" | grep -Eo "[0-9.]+")
    if [ "$XMAKE" != "$XMAKE_LATEST" ]; then
        XMAKE_LATEST=0
    else
        XMAKE_LATEST=1
    fi
fi

TAG_PREFIX="diguser/xmake-mingw-w64"
TAGS=()
XMAKE_VERSION=(${XMAKE//./ })
TAGS+=("-t $TAG_PREFIX:${XMAKE_VERSION[0]}")
TAGS+=("-t $TAG_PREFIX:${XMAKE_VERSION[0]}.${XMAKE_VERSION[1]}")
TAGS+=("-t $TAG_PREFIX:${XMAKE_VERSION[0]}.${XMAKE_VERSION[1]}.${XMAKE_VERSION[2]}")
if [ $XMAKE_LATEST -eq 1 ]; then
    TAGS+=("-t $TAG_PREFIX:latest")
fi

if [ -n "$(command -v docker)" ]; then
    echo "=== Build docker with ubuntu:$UBUNTU and xmake:$XMAKE"
    docker build \
        ${TAGS[@]} \
        --build-arg ubuntu=$UBUNTU \
        --build-arg xmake=$XMAKE \
        --compress \
        .
    if [ -n "$PUSH" ]; then
        for TAG in "${TAGS[@]}"; do
            TAG=${TAG#-t }
            echo "Pushing tag $TAG to registry..."
            docker push $TAG
        done
    fi
elif [ -n "$(command -v podman)" ]; then
    echo "=== Build podman with ubuntu:$UBUNTU and xmake:$XMAKE"
    podman build \
        ${TAGS[@]} \
        --build-arg ubuntu=$UBUNTU \
        --build-arg xmake=$XMAKE \
        --compress \
        .
    if [ -n "$PUSH" ]; then
        for TAG in "${TAGS[@]}"; do
            TAG=${TAG#-t }
            echo "=== Pushing tag $TAG to registry..."
            podman push $TAG
        done
    fi
else
    echo "<!> Neither docker nor podman is available. Please install one of them to build the image."
    exit 1
fi