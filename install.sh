#!/usr/bin/env bash

curl https://gitlab.com/ceda_ei/wish/-/archive/master/wish-master.tar -o /tmp/wish.tar
cd /tmp/
tar xf wish.tar
mv wish-master/ wish/
mv wish/ $HOME/.config/
cat >> ~/.bashrc <<EOF

# Wish

WISH_PLUGINS=(exit_code_smiley bg_jobs date path newline vcs)
WISH_THEME=plain
source ~/.config/wish/wish.sh
EOF

