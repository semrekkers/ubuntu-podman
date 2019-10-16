#!/bin/bash

set -e

PODMAN_DEFAULT_VERSION="v1.6.1"

PODMAN_VERSION=${PODMAN_VERSION:-$PODMAN_DEFAULT_VERSION}

git clone "https://github.com/containers/libpod.git" src/github.com/containers/libpod
cd src/github.com/containers/libpod
git checkout -q $PODMAN_VERSION
make podman BUILDTAGS="seccomp systemd exclude_graphdriver_btrfs exclude_graphdriver_devicemapper"

exec "$@"
