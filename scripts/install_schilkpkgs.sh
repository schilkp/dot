#!/bin/sh
mkdir -p ~/.local/bin
touch ~/.local/bin/SchilkPKGs
echo "#!/bin/sh" > ~/.local/bin/SchilkPKGs
echo "python ~/dot/utils/SchilkPKGs \$@" >> ~/.local/bin/SchilkPKGs
chmod +x ~/.local/bin/SchilkPKGs
