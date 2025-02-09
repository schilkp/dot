#!/bin/bash
set -e -x

TARGET="$HOME/.local/packages/nvim"
INSTALL_DIR="$HOME/.local/bin"
JOBS=32

mkdir -p "$TARGET"

cd "$TARGET"

git clone https://github.com/neovim/neovim.git
cd neovim

make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX="$TARGET" -j "$JOBS"
make install

install ./bin/nvim "$INSTALL_DIR"
