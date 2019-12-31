#!/usr/bin/env bash

# INTERNAL USE ONLY! Do not use this in plugins.
function wish_print_right_prompt() {
	local idx=0
	for i in ${WISH_RPL[@]}; do
		echo "\e[$(($COLUMNS - $i + 1))G${WISH_RIGHT_PS1[$idx]}"
		((idx++))
	done
}

function wish_init() {
	# Find default config file if WISH_CONFIG_FILE is unset
	if [[ ! -v WISH_CONFIG_FILE ]]; then
		for path in "$XDG_CONFIG_HOME" "/usr/share" "$HOME/.config"; do
			if [[ -f "$path/wish/config.gie" ]]; then
				WISH_CONFIG_FILE="$path/wish/config.gie"
				break
			fi
		done
	fi
	# Source config files
	for path in "$XDG_CONFIG_HOME" "/usr/share" "$HOME/.config"; do
		if [[ -f "$path/wish/wish.py" ]]; then
			source <($path/wish/wish.py ${WISH_CONFIG_FILE[@]})
			break
		fi
	done
	# Source all plugins
	# If WISH_CONFIG_FILE is not set, then assume that the user hasn't updated
	# to a config file yet. Set WISH_PLUGINS_SOURCE=WISH_PLUGINS.
	if [[ ! -v WISH_CONFIG_FILE ]]; then
		WISH_PLUGINS_SOURCE=("${WISH_PLUGINS[@]}" "${WISH_RIGHT_PLUGINS[@]}")
	fi
	local plugin
	local path
	for plugin in ${WISH_PLUGINS_SOURCE[@]}; do
		for path in "$XDG_CONFIG_HOME" "/usr/share" "$HOME/.config"; do
			source "$path/wish/plugins/$plugin.sh" &> /dev/null && break
		done
		[[ $? -ne 0 ]] && echo "Plugin $plugin not found." >&2
	done

	# Source theme
	WISH_THEME=${WISH_THEME:-plain}
	while :; do
		for theme in "$XDG_CONFIG_HOME" "/usr/share" "$HOME/.config"; do
			source "$theme/wish/themes/$WISH_THEME.sh" &> /dev/null && break
		done
		if [[ $? -eq 0 ]]; then
			break
		else
			echo "Theme $WISH_THEME not found. Using theme plain." >&2
			if [[ $WISH_THEME == "plain" ]]; then
				break
			else
				WISH_THEME=plain
			fi
		fi
	done

	# Call plugins to set colors
	for plugin in ${WISH_PLUGINS[@]} ${WISH_RIGHT_PLUGINS[@]}; do
		eval wish_$(echo $plugin)_set_colors $prev
	done
}

# Usage: color_to_escape_code [3|4] color
#
# Parameters:
# - [3|4]: Use 3 if escape code is for foreground, 4 for background
# - color: -1 to reset, 0-255 for terminal color codes. 6 digit hexadecimal
# value for true color.
#
# Return value: Prints escape code that sets the fg/bg as requested.
function color_to_escape_code() {
	local choice=$1
	local color=$2
	if [[ $color == -1 ]]; then
		echo "\[\033[0;5;0m\]"
	else
		if [[ ${#fg_code} -eq 6 ]]; then
			local r=$(( 16#${color:0:2} ))
			local g=$(( 16#${color:2:2} ))
			local b=$(( 16#${color:4:2} ))
			echo "\[\033[${choice}8;2;$r;$g;${b}m\]"
		else
			echo "\[\033[${choice}8;5;${fg_code}m\]"
		fi
	fi
}
# INTERNAL USE ONLY! Do not use this in plugins.
# Usage: wish_append_left escape_codes text
function wish_append_left() {
	local text="$2"
	local colors="$1"
	local prompt_text="${text@P}"
	if [[ $text == "\n" ]]; then
		((WISH_LPLINE++))
		WISH_LPL=(${WISH_LPL[@]} 0)
		WISH_LEFT_PS1="$WISH_LEFT_PS1$colors$text"
	else
		if [[ $((${WISH_LPL[$WISH_LPLINE]} + ${#prompt_text})) -lt $COLUMNS ]]; then
			WISH_LEFT_PS1="$WISH_LEFT_PS1$colors$text"
			WISH_LPL[$WISH_LPLINE]=$((${WISH_LPL[$WISH_LPLINE]} + ${#prompt_text}))
		fi
	fi
}

# INTERNAL USE ONLY! Do not use this in plugins.
# Usage: wish_append_right escape_codes text
function wish_append_right() {
	local text="$2"
	local colors="$1"
	local prompt_text="${text@P}"
	if [[ $text == "\n" ]]; then
		((WISH_RPLINE++))
		WISH_RIGHT_PS1=("${WISH_RIGHT_PS1[@]}" "")
		WISH_RPL=(${WISH_RPL[@]} 0)
	elif [[ $((${WISH_LPL[$WISH_RPLINE]} + ${WISH_RPL[$WISH_RPLINE]} + ${#prompt_text})) -lt $COLUMNS ]]; then
		WISH_RIGHT_PS1[$WISH_RPLINE]="${WISH_RIGHT_PS1[$WISH_RPLINE]}$colors$text"
		WISH_RPL[$WISH_RPLINE]=$((${WISH_RPL[$WISH_RPLINE]} + ${#prompt_text}))
	fi
}

# Public API
# Usage: wish_append bg fg text
#
# Parameters:
# - fg, bg: -1 to reset, 0-255 for terminal color codes. 6 digit hexadecimal
# value for true color.
# - text: Text of the plugin
#
# Return value: None
function wish_append() {
	local bg_code=$1
	local fg_code=$2
	local text=$3
	local fg=$(color_to_escape_code 3 $fg_code)
	local bg=$(color_to_escape_code 4 $bg_code)

	if [[ $fg_code == -1 ]]; then
		case $WISH_STATE in
			0)
				wish_append_left "$fg$bg" "$text"
				;;
			1)
				wish_append_right "$fg$bg" "$text"
				;;
		esac
	else
		case $WISH_STATE in
			0)
				wish_append_left "$bg$fg" "$text"
				;;
			1)
				wish_append_right "$bg$fg" "$text"
				;;
		esac
	fi
}

# Public API
# Usage: wish_remaining_chars
# Parameters: None
# Return Value: Capture stdout to get the remaining characters available in the
# line.
wish_remaining_chars() {
	if [[ $WISH_STATE -eq 0 ]]; then
		echo "$(( $COLUMNS - ${WISH_LPL[$WISH_LPLINE]} ))"
	else
		echo "$(( $COLUMNS - ${WISH_LPL[$WISH_RPLINE]} - ${WISH_RPL[$WISH_RPLINE]} ))"
	fi
}

function wish_main() {
	local prev=$?
	# Set local IFS to avoid being affected by shell's IFS
	local IFS=$' \n'
	PS1=""
	WISH_LEFT_PS1=""
	WISH_RIGHT_PS1=("")
	WISH_LPL=(0)
	WISH_RPL=(0)
	WISH_RPLINE=0
	WISH_LPLINE=0
	local i
	# Set newline
	if [[ $WISH_AUTONEWLINE != 0 ]]; then
		echo -ne "\033[6n" ; read -s -d ';'; read -s -d R WISH_CURSOR_POSITION
		if [[ $WISH_CURSOR_POSITION != "1" ]]; then
			PS1="\n"
		fi
	fi
	# Generate left prompt.
	WISH_STATE=0  # 0 = left prompt, 1 = right prompt
	for i in $(seq 0 $((${#WISH_PLUGINS[@]} - 1))); do
		wish_${WISH_PLUGINS[i]}_main $prev
		if [[ -v WISH_POWERLINE ]] && [[ $WISH_POWERLINE != 0 ]]; then
			if wish_${WISH_PLUGINS[$i]}_end $prev; then
				if [[ $i -lt $((${#WISH_PLUGINS[@]} - 1)) ]]; then
					if wish_${WISH_PLUGINS[$(($i + 1))]}_start $prev; then
						local plugin=${WISH_PLUGINS[$i]}
						local next_plugin=${WISH_PLUGINS[$(($i+1))]}
						local fg_name="WISH_${plugin^^}_BG"
						local bg_name="WISH_${next_plugin^^}_BG"
						wish_append ${!bg_name} ${!fg_name} 
					fi
				else
					local plugin=${WISH_PLUGINS[$i]}
					local fg_name="WISH_${plugin^^}_BG"
					wish_append -1 ${!fg_name} 
				fi
			fi
		fi
	done
	# Generate Right prompt.
	WISH_STATE=1
	for i in $(seq 0 $((${#WISH_RIGHT_PLUGINS[@]} - 1))); do
		if [[ -v WISH_POWERLINE ]] && [[ $WISH_POWERLINE != 0 ]]; then
			if wish_${WISH_RIGHT_PLUGINS[$i]}_end $prev; then
				if [[ $i == 0 ]]; then
					local plugin=${WISH_RIGHT_PLUGINS[$i]}
					local fg_name="WISH_${plugin^^}_BG"
					wish_append -1 ${!fg_name} 
				elif wish_${WISH_RIGHT_PLUGINS[$(($i - 1))]}_start $prev; then
					local plugin=${WISH_RIGHT_PLUGINS[$i]}
					local prev_plugin=${WISH_RIGHT_PLUGINS[$(($i-1))]}
					local fg_name="WISH_${plugin^^}_BG"
					local bg_name="WISH_${prev_plugin^^}_BG"
					wish_append ${!bg_name} ${!fg_name} 
				fi
			fi
		fi
		wish_${WISH_RIGHT_PLUGINS[$i]}_main $prev
	done
	# Save cursor position, print right prompt, restore cursor position,
	# print left prompt, reset terminal
	PS1=$PS1"\[\e7"
	PS1="$PS1$(wish_print_right_prompt)"
	PS1="$PS1\e8\]$WISH_LEFT_PS1\[\033[0;5;0m\]"
}

wish_init
PROMPT_COMMAND="wish_main; $PROMPT_COMMAND"
