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
	wish_append $WISH_PATH_BG $WISH_PATH_FG " \w "
}
