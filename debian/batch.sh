#!/bin/bash
VERSIONS=(
    trixie
    forky
    latest
)

for VERSION in "${VERSIONS[@]}"; do
    DEBIAN=$VERSION ./build.sh
    if [ $? -ne 0 ]; then
        echo "Build failed for Debian $VERSION."
        exit 1
    fi
done
