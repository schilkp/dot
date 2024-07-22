#!/bin/bash

TARGET="$HOME/.local/nvim"
INSTALL_DIR="$HOME/.local/bin"
JOBS=32

mkdir -p $TARGET

git clone https://github.com/neovim/neovim.git
cd neovim
# checkout here

make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX="$TARGET" -j "$JOBS"
make install

#TODO: copy
