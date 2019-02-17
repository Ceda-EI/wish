function wish_path_start() {
	return 0
}

function wish_path_end() {
	return 0
}

function wish_path_set_colors() {
	WISH_PATH_FG=${WISH_PATH_FG:-$WISH_DEFAULT_FG}
	WISH_PATH_BG=${WISH_PATH_BG:-$WISH_DEFAULT_BG}
	WISH_PATH_NO_WRITE_SUFFIX=${WISH_PATH_NO_WRITE_SUFFIX:- }
}

function wish_path_main() {
	if [[ -w $PWD ]]; then
		local path=" \w "
	else
		local path=" \w$WISH_PATH_NO_WRITE_SUFFIX "
	fi
	wish_append $WISH_PATH_BG $WISH_PATH_FG "$path"
}
