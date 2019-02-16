function wish_path_start() {
	return 0
}

function wish_path_end() {
	return 0
}

function wish_path_set_colors() {
	WISH_PATH_FG=${WISH_PATH_FG:-$WISH_DEFAULT_FG}
	WISH_PATH_BG=${WISH_PATH_BG:-$WISH_DEFAULT_BG}
}

function wish_path_main() {
	if [[ $fg -eq -1 ]]; then
		local fg="\[\033[0;5;0m\]"
	else
		local fg="\[\033[38;5;${WISH_PATH_FG}m\]"
	fi
	if [[ $bg -eq -1 ]]; then
		local bg="\[\033[0;5;0m\]"
	else
		local bg="\[\033[48;5;${WISH_PATH_BG}m\]"
	fi
	PS1="$PS1$fg${bg} \w "
}
