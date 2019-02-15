#!/usr/bin/env bash

function wish_init() {
	# Source all plugins
	local i
	local j
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
}


function wish_main() {
	local prev=$?
	PS1=""
	local i
	for i in $(seq 0 $((${#WISH_PLUGINS[@]} - 1))); do
		wish_${WISH_PLUGINS[i]}_main $prev
	done
}

wish_init
PROMPT_COMMAND="wish_main; $PROMPT_COMMAND"
