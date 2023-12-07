#!/usr/bin/env bash

if hash git; then
	git clone https://gitlab.com/ceda_ei/Wish.git $HOME/.config/wish
else
	echo 'Git not found. Please install git.' >&2
	exit 1
fi
cp $HOME/.config/wish/config.default.gie $HOME/.config/wish/config.gie

cat >> ~/.bashrc <<EOF

# Wish
WISH_CONFIG_FILE="$HOME/.config/wish/config.gie"
source $HOME/.config/wish/wish.sh
EOF
