# Wish

A customizable bash prompt.

# Installation

## One step Installation

`curl https://gitlab.com/ceda_ei/wish/raw/master/install.sh | bash`

## Manual Installation

+ `cd ~/.config/`
+ `git clone https://gitlab.com/ceda_ei/wish.git`
+ Add the following lines to ~/.bashrc

```
WISH_PLUGINS=(exit_code_smiley bg_jobs date path newline vcs)
WISH_THEME=plain
source ~/.config/wish/wish.sh
```

# Customization

+ To change the order of plugins, edit the `WISH_PLUGINS` array.
+ To change the theme, edit the `WISH_THEME` variable.
+ To enable/disable powerline fonts, set `WISH_POWERLINE` to `1` or `0`.

## Example config

![Example Config](screenshots/example_config.png)
```
WISH_DATE_FORMAT="%d %b %H:%M" # Look in date plugin for details
WISH_PLUGINS=(newline exit_code bg_jobs tmux date battery path python_venv newline vcs space)
WISH_POWERLINE=1
WISH_THEME=rgb_gradient
```
