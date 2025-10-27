#!/bin/bash
VERSIONS=(
    noble
    plucky
    questing
    latest
)

for VERSION in "${VERSIONS[@]}"; do
    UBUNTU=$VERSION ./build.sh
    if [ $? -ne 0 ]; then
        echo "Build failed for Ubuntu $VERSION."
        exit 1
    fi
done
