function wish_exit_code_smiley_start() {
	return 0
}

function wish_exit_code_smiley_end() {
	return 0
}

function wish_exit_code_smiley_set_colors() {
	WISH_EXIT_CODE_SMILEY_FG=${WISH_EXIT_CODE_SMILEY_FG:-$WISH_DEFAULT_FG}
	WISH_EXIT_CODE_SMILEY_BG=${WISH_EXIT_CODE_SMILEY_BG:-$WISH_DEFAULT_BG}
	WISH_EXIT_CODE_SMILEY_PASS=${WISH_EXIT_CODE_SMILEY_PASS:- :) }
	WISH_EXIT_CODE_SMILEY_FAIL=${WISH_EXIT_CODE_SMILEY_FAIL:- :( }
}

function wish_exit_code_smiley_main() {
	if [[ $1 == 0 ]]; then
		wish_append $WISH_EXIT_CODE_SMILEY_BG $WISH_EXIT_CODE_SMILEY_FG "$WISH_EXIT_CODE_SMILEY_PASS"
	else
		wish_append $WISH_EXIT_CODE_SMILEY_BG $WISH_EXIT_CODE_SMILEY_FG "$WISH_EXIT_CODE_SMILEY_FAIL"
	fi
}
