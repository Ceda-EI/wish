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

	# Call plugins to set colors
	for i in ${WISH_PLUGINS[@]}; do
		eval wish_$(echo $i)_set_colors $prev
	done
}

# Usage: wish_append bg fg text
function wish_append() {
	local bg_code=$1
	local fg_code=$2
	local text=$3
	if [[ $fg_code -eq -1 ]]; then
		local fg="\[\033[0;5;0m\]"
	else
		local fg="\[\033[38;5;${fg_code}m\]"
	fi
	if [[ $bg_code -eq -1 ]]; then
		local bg="\[\033[0;5;0m\]"
	else
		local bg="\[\033[48;5;${bg_code}m\]"
	fi
	if [[ $fg_code -eq -1 ]]; then
		PS1="$PS1$fg${bg}$text"
	else
		PS1="$PS1$bg${fg}$text"
	fi
}


function wish_main() {
	local prev=$?
	PS1=""
	local i
	for i in $(seq 0 $((${#WISH_PLUGINS[@]} - 1))); do
		wish_${WISH_PLUGINS[i]}_main $prev
		if [[ -v WISH_POWERLINE ]] && [[ $WISH_POWERLINE != 0 ]]; then
			if wish_${WISH_PLUGINS[$i]}_end $prev; then
				if [[ $i -lt $((${#WISH_PLUGINS[@]} - 1)) ]]; then
					if wish_${WISH_PLUGINS[$(($i + 1))]}_start $prev; then
						local plugin=${WISH_PLUGINS[$i]}
						local next_plugin=${WISH_PLUGINS[$(($i+1))]}
						local fg=$(eval echo \$WISH_$(echo $plugin |
							tr '[:lower:]' '[:upper:]')_BG)
						local bg=$(eval echo \$WISH_$(echo $next_plugin |
							tr '[:lower:]' '[:upper:]')_BG)
						wish_append $bg $fg 
					fi
				else
					local plugin=${WISH_PLUGINS[$i]}
					local fg=$(eval echo \$WISH_$(echo $plugin |
						tr '[:lower:]' '[:upper:]')_BG)
					wish_append -1 $fg 
				fi
			fi
		fi

		if [[ $i -eq $((${#WISH_PLUGINS[@]} - 1)) ]]; then
			PS1="$PS1\[\033[0;5;0m\]"
		fi
	done
}

wish_init
PROMPT_COMMAND="wish_main; $PROMPT_COMMAND"
