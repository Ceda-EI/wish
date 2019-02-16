function wish_newline_start() {
	return 0
}

function wish_newline_end() {
	return 1
}

function wish_newline_set_colors() {
	WISH_NEWLINE_BG=-1
	WISH_NEWLINE_FG=-1
}

function wish_newline_main() {
	wish_append -1 -1 "\n"
}
