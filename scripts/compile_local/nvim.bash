#!/bin/bash
set -e -x

TARGET="$HOME/.local/packages/nvim"
INSTALL_DIR="$HOME/.local/bin"
JOBS=32
VERSION="v0.11.0"

mkdir -p "$TARGET"
cd "$TARGET"

if [ ! -d "$TARGET/neovim" ]; then
    echo "Cloning Neovim repository..."
    git clone https://github.com/neovim/neovim.git "$TARGET/neovim"
else
    echo "Neovim repository already exists at $TARGET/neovim"
fi

cd "$TARGET/neovim"
git checkout $VERSION

make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX="$TARGET" -j "$JOBS"
make install

install "$TARGET"/neovim/build/bin/nvim "$INSTALL_DIR"
