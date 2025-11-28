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

CONFIGURE_FLAGS="--enable-sixel"

# For local ncurses + libevent:
PKG_CONFIG_PATH="$HOME"/.local/lib/pkgconfig ./configure --prefix="$HOME"/.local $CONFIGURE_FLAGS
# For global ncurses + libevent:
# ./configure --prefix="$HOME/.local" $CONFIGURE_FLAGS

make -j "$JOBS"
make install

# Convert tmux bin to script that sets correct env vars
mv "$HOME"/.local/bin/tmux "$HOME"/.local/bin/tmux_actual
echo "#!/bin/bash" > ~/.local/bin/tmux
echo "LD_LIBRARY_PATH_ORIG=\"\$LD_LIBRARY_PATH\" LD_LIBRARY_PATH=\"$HOME\"/.local/lib \"$HOME\"/.local/bin/tmux_actual \"\$@\"" >>  ~/.local/bin/tmux
chmod +x ~/.local/bin/tmux
