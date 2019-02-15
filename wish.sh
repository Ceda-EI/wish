#!/usr/bin/env bash

# Source all plugins
for i in ${WISH_PLUGINS[@]}; do
	for j in "$XDG_CONFIG_HOME" "/usr/share" "$HOME/.config"; do
		source "$j/wish/plugins/$i.sh" &> /dev/null && break
	done
	[[ $? -ne 0 ]] && echo "Plugin $i not found." >&2
done

# Source theme
WISH_THEME=${WISH_THEME:-plain}
for i in "$XDG_CONFIG_HOME" "/usr/share" "$HOME/.config"; do
	source "$i/wish/themes/$WISH_THEME.sh" &> /dev/null && break
done

[[ $? -ne 0 ]] && echo "Theme $WISH_THEME not found." >&2
