#!/bin/bash
set -e -x

TARGET="$HOME/.local/compile_local/tmux-libevent"
VERSION="2.1.12-stable"
JOBS=$(nproc)

mkdir -p "$TARGET"
cd "$TARGET"

wget https://github.com/libevent/libevent/releases/download/release-"$VERSION"/libevent-"$VERSION".tar.gz
tar xvfz libevent-"$VERSION".tar.gz

cd libevent-"$VERSION"

./configure --prefix="$HOME/.local" --enable-shared
make -j "$JOBS"
make install
