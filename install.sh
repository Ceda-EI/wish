#!/usr/bin/env bash

if hash git; then
	git clone https://gitlab.com/ceda_ei/Wish.git $HOME/.config/wish
else
	curl https://gitlab.com/ceda_ei/wish/-/archive/master/wish-master.tar -o /tmp/wish.tar
	mkdir $HOME/.config 2> /dev/null
	cd /tmp/
	tar xf wish.tar
	mv wish-master/ wish/
	mv wish/ $HOME/.config/
fi
cp $HOME/.config/wish/config.default.gie $HOME/.config/wish/config.gie

cat >> ~/.bashrc <<EOF

# Wish
WISH_CONFIG_FILE="$HOME/.config/wish/config.gie"
source $HOME/.config/wish/wish.sh
EOF
