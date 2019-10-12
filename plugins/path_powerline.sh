function wish_path_powerline_start() {
	return 0
}

function wish_path_powerline_end() {
	return 0
}

function wish_path_powerline_set_colors() {
	WISH_PATH_POWERLINE_FG=${WISH_PATH_POWERLINE_FG:-$WISH_DEFAULT_FG}
	WISH_PATH_POWERLINE_BG=${WISH_PATH_POWERLINE_BG:-$WISH_DEFAULT_BG}
	WISH_PATH_POWERLINE_NO_WRITE_SUFFIX=${WISH_PATH_POWERLINE_NO_WRITE_SUFFIX:- }
}

function wish_path_powerline_main() {
	local path="${PWD/#$HOME/\~}"
	local path="${path//\//  }"
	if [[ -w $PWD ]]; then
		local path=" $path "
	else
		local path=" $path$WISH_PATH_POWERLINE_NO_WRITE_SUFFIX "
	fi
	wish_append $WISH_PATH_POWERLINE_BG $WISH_PATH_POWERLINE_FG "$path"
}
