#!/bin/bash
set -e -x

TARGET="$HOME/.local/compile_local/tmux-ncurses"
JOBS=$(nproc)

mkdir -p "$TARGET"
cd "$TARGET"

wget https://invisible-island.net/datafiles/release/ncurses.tar.gz
tar xvfz ncurses.tar.gz

cd ncurses-*

./configure --prefix=$HOME/.local --with-shared --with-termlib --enable-pc-files --with-pkg-config-libdir=$HOME/.local/lib/pkgconfig
make -j "$JOBS"
make install
