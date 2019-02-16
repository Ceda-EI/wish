function wish_exit_code_start() {
	return 0
}

function wish_exit_code_end() {
	return 0
}

function wish_exit_code_set_colors() {
	WISH_EXIT_CODE_FG=${WISH_EXIT_CODE_FG:-$WISH_DEFAULT_FG}
	WISH_EXIT_CODE_BG=${WISH_EXIT_CODE_BG:-$WISH_DEFAULT_BG}
}

function wish_exit_code_main() {
	if [[ $1 == 0 ]]; then
		wish_append $WISH_EXIT_CODE_BG $WISH_EXIT_CODE_FG ""
	else
		wish_append $WISH_EXIT_CODE_BG $WISH_EXIT_CODE_FG $1
	fi
}
