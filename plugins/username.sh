function wish_username_start() {
	return 0
}

function wish_username_end() {
	return 0
}

function wish_username_set_colors() {
	WISH_USERNAME_FG=${WISH_USERNAME_FG:-$WISH_DEFAULT_FG}
	WISH_USERNAME_BG=${WISH_USERNAME_BG:-$WISH_DEFAULT_BG}
}

function wish_username_main() {
	wish_append $WISH_USERNAME_BG $WISH_USERNAME_FG " \u "
}
