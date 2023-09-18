#!/bin/sh
mkdir -p ~/.local/bin
touch ~/.local/bin/SchilkPKGs
echo "#!/bin/sh" > ~/.local/bin/SchilkPKGs
echo "python ~/dotfiles/utils/SchilkPKGs \$@" >> ~/.local/bin/SchilkPKGs
chmod +x ~/.local/bin/SchilkPKGs
