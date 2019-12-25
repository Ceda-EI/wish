function wish_hostname_start() {
	return 0
}

function wish_hostname_end() {
	return 0
}

function wish_hostname_set_colors() {
	WISH_HOSTNAME_FG=${WISH_HOSTNAME_FG:-$WISH_DEFAULT_FG}
	WISH_HOSTNAME_BG=${WISH_HOSTNAME_BG:-$WISH_DEFAULT_BG}
}

function wish_hostname_main() {
	wish_append $WISH_HOSTNAME_BG $WISH_HOSTNAME_FG " \h "
}
