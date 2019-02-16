function wish_date_start() {
	return 0
}

function wish_date_end() {
	return 0
}

function wish_date_set_colors() {
	WISH_DATE_FG=${WISH_DATE_FG:-$WISH_DEFAULT_FG}
	WISH_DATE_BG=${WISH_DATE_BG:-$WISH_DEFAULT_BG}
}

function wish_date_main() {
	local date_format=${WISH_DATE_FORMAT:-"%F %T"}
	wish_append $WISH_DATE_BG $WISH_DATE_FG " $(date "+$date_format") "
}
