#!/bin/bash
set -x -e

mkdir -p dist
for ARCH in amd64 arm arm64 ppc ppc64 ppc64le; do
    docker build --build-arg ARCH=${ARCH} -t k3s-root:${ARCH} .
    docker run -i --rm -v k3s-root-cache:/usr/src/ccache k3s-root:${ARCH} tar cf - -C /usr/src ./bin ./etc > dist/k3s-root-${ARCH}.tar
done
