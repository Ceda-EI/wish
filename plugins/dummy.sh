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
	wish_append $WISH_DUMMY_BG $WISH_DUMMY_FG dummy
}
