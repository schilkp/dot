#!/bin/bash
set -e -x

TARGET="$HOME/.local/packages/tmux"
JOBS=32
VERSION="3.5a"

mkdir -p "$TARGET"
cd "$TARGET"

wget https://github.com/tmux/tmux/releases/download/"$VERSION"/tmux-"$VERSION".tar.gz
tar xvfz tmux-"$VERSION".tar.gz

cd tmux-"$VERSION"

# For local ncurses + libevent:
PKG_CONFIG_PATH="$HOME"/.local/lib/pkgconfig ./configure --prefix="$HOME"/local
# For global ncurses + libevent:
# ./configure --prefix="$HOME/local"

make -j "$JOBS"
make install
