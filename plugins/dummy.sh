function wish_dummy_start() {
	return 0
}

function wish_dummy_end() {
	return 0
}

function wish_dummy_set_colors() {
	WISH_DUMMY_FG=${WISH_DUMMY_FG:-$WISH_DEFAULT_FG}
	WISH_DUMMY_BG=${WISH_DUMMY_BG:-$WISH_DEFAULT_BG}
}

function wish_dummy_main() {
	if [[ $fg -eq -1 ]]; then
		local fg="\[\033[0;5;0m\]"
	else
		local fg="\[\033[38;5;${WISH_DUMMY_FG}m\]"
	fi
	if [[ $bg -eq -1 ]]; then
		local bg="\[\033[0;5;0m\]"
	else
		local bg="\[\033[48;5;${WISH_DUMMY_BG}m\]"
	fi
	PS1="$PS1$bg${fg}dummy"
}
