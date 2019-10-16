#!/bin/bash

set -e

CONMON_DEFAULT_VERSION="v2.0.1"
CRUN_DEFAULT_VERSION="0.10"
FUSE_OVERLAYFS_DEFAULT_VERSION="v0.6.5"

CONMON_VERSION=${CONMON_VERSION:-$CONMON_DEFAULT_VERSION}
CRUN_VERSION=${CRUN_VERSION:-$CRUN_DEFAULT_VERSION}
FUSE_OVERLAYFS_VERSION=${FUSE_OVERLAYFS_VERSION:-$FUSE_OVERLAYFS_DEFAULT_VERSION}

git clone "https://github.com/containers/conmon.git" src/github.com/containers/conmon
cd src/github.com/containers/conmon
git checkout -q $CONMON_VERSION
make
cd

git clone "https://github.com/giuseppe/crun.git" src/github.com/giuseppe/crun
cd src/github.com/giuseppe/crun
git checkout -q $CRUN_VERSION
./autogen.sh
./configure
make

git clone "https://github.com/containers/fuse-overlayfs.git" src/github.com/containers/fuse-overlayfs
cd src/github.com/containers/fuse-overlayfs
git checkout -q $FUSE_OVERLAYFS_VERSION


exec "$@"
