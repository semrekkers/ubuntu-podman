#!/bin/bash

set -e

if [ "$1" == "--clean" ]; then
    docker rmi -f \
        ubuntu-podman-podman \
        ubuntu-podman-slirp4netns \
        ubuntu-podman-fuse-overlayfs \
        ubuntu-podman-crun \
        ubuntu-podman-conmon \
        ubuntu-podman-base-go \
        ubuntu-podman-base \
        ubuntu-podman-dep-fuse-overlayfs
    rm -rf deps
    rm -rf dist
fi

function install-from-image {
    echo "Installing $1 from image..."
    if [ -f $3 ]; then return; fi
    docker run --rm ubuntu-podman-$1 cat $2 > $3
    chmod +x "$3"
}

if [ ! -d deps/fuse-overlayfs ]; then
    git clone "https://github.com/containers/fuse-overlayfs.git" deps/fuse-overlayfs
    cd deps/fuse-overlayfs
    git checkout -q v0.6.5
    cd ../..
fi

cd deps/fuse-overlayfs
docker build -f Dockerfile.static -t ubuntu-podman-dep-fuse-overlayfs .
cd ../..

docker build -f Base.df -t ubuntu-podman-base .
docker build -f Base-go.df -t ubuntu-podman-base-go .

docker build -f Conmon.df -t ubuntu-podman-conmon .
docker build -f Crun.df -t ubuntu-podman-crun .
docker build -f Fuse-overlayfs.df -t ubuntu-podman-fuse-overlayfs .
docker build -f Slirp4netns.df -t ubuntu-podman-slirp4netns .

docker build -f Podman.df -t ubuntu-podman-podman .

mkdir -p dist/usr/bin
mkdir -p dist/usr/share/containers
mkdir -p dist/etc/containers

install-from-image conmon bin/conmon dist/usr/bin/conmon
install-from-image crun crun dist/usr/bin/crun
install-from-image fuse-overlayfs fuse-overlayfs dist/usr/bin/fuse-overlayfs
install-from-image slirp4netns slirp4netns dist/usr/bin/slirp4netns
install-from-image podman bin/podman dist/usr/bin/podman

echo "Installing default configuration..."
cp -n config/registries.conf dist/etc/containers
cp -n config/seccomp.json dist/usr/share/containers
cp -n config/policy.json dist/etc/containers/

echo "Creating distribution..."
tar -cJf ubuntu-podman.tar.xz dist
