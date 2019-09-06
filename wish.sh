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
	if [[ $fg_code == -1 ]]; then
		local fg="\[\033[0;5;0m\]"
	else
		if [[ ${#fg_code} -eq 6 ]]; then
			local color=($(echo $fg_code | grep -o .))
			local r=$(( 16#${color[0]}${color[1]} ))
			local g=$(( 16#${color[2]}${color[3]} ))
			local b=$(( 16#${color[4]}${color[5]} ))
			local fg="\[\033[38;2;$r;$g;${b}m\]"
		else
			local fg="\[\033[38;5;${fg_code}m\]"
		fi
	fi
	if [[ $bg_code == -1 ]]; then
		local bg="\[\033[0;5;0m\]"
	else
		if [[ ${#bg_code} -eq 6 ]]; then
			local color=($(echo $bg_code | grep -o .))
			local r=$(( 16#${color[0]}${color[1]} ))
			local g=$(( 16#${color[2]}${color[3]} ))
			local b=$(( 16#${color[4]}${color[5]} ))
			local bg="\[\033[48;2;$r;$g;${b}m\]"
		else
			local bg="\[\033[48;5;${bg_code}m\]"
		fi
	fi

	if [[ $fg_code == -1 ]]; then
		PS1="$PS1$fg${bg}$text"
	else
		PS1="$PS1$bg${fg}$text"
	fi
}


function wish_main() {
	local prev=$?
	PS1=""
	local i
	if [[ $WISH_AUTONEWLINE != 0 ]]; then
		echo -ne "\033[6n" ; read -s -d ';'; read -s -d R WISH_CURSOR_POSITION
		if [[ $WISH_CURSOR_POSITION != "1" ]]; then
			PS1="\n"
		fi
	fi
	for i in $(seq 0 $((${#WISH_PLUGINS[@]} - 1))); do
		wish_${WISH_PLUGINS[i]}_main $prev
		if [[ -v WISH_POWERLINE ]] && [[ $WISH_POWERLINE != 0 ]]; then
			if wish_${WISH_PLUGINS[$i]}_end $prev; then
				if [[ $i -lt $((${#WISH_PLUGINS[@]} - 1)) ]]; then
					if wish_${WISH_PLUGINS[$(($i + 1))]}_start $prev; then
						local plugin=${WISH_PLUGINS[$i]}
						local next_plugin=${WISH_PLUGINS[$(($i+1))]}
						local fg_name=$(echo WISH_$(echo $plugin |
							tr '[:lower:]' '[:upper:]')_BG)
						local bg_name=$(echo WISH_$(echo $next_plugin |
							tr '[:lower:]' '[:upper:]')_BG)
						wish_append ${!bg_name} ${!fg_name} 
					fi
				else
					local plugin=${WISH_PLUGINS[$i]}
					local fg_name=$(echo WISH_$(echo $plugin |
						tr '[:lower:]' '[:upper:]')_BG)
					wish_append -1 ${!fg_name} 
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
