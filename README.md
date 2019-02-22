# Wish

A customizable bash prompt.

# Installation

## One step Installation

`curl https://gitlab.com/ceda_ei/wish/raw/master/install.sh | bash`

## Manual Installation

+ `cd ~/.config/`
+ `git clone https://gitlab.com/ceda_ei/wish.git`
+ Add the following lines to ~/.bashrc

```bash
WISH_PLUGINS=(exit_code_smiley bg_jobs date path newline vcs)
WISH_THEME=plain
source ~/.config/wish/wish.sh
```

# Wiki

[Check the wiki for details about customization and plugins.](https://gitlab.com/ceda_ei/wish/wikis/home)
