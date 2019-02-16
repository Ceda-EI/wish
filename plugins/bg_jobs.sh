function wish_bg_jobs_start() {
	return 0
}

function wish_bg_jobs_end() {
	return 0
}

function wish_bg_jobs_set_colors() {
	WISH_BG_JOBS_FG=${WISH_BG_JOBS_FG:-$WISH_DEFAULT_FG}
	WISH_BG_JOBS_BG=${WISH_BG_JOBS_BG:-$WISH_DEFAULT_BG}
	WISH_BG_JOBS_SUFFIX=${WISH_BG_JOBS_SUFFIX:-&}
}

function wish_bg_jobs_main() {
	local x=$(jobs -p | wc -l)
	if [[ $x == 0 ]]; then
		wish_append $WISH_BG_JOBS_BG $WISH_BG_JOBS_FG ""
	else
		wish_append $WISH_BG_JOBS_BG $WISH_BG_JOBS_FG " $x$WISH_BG_JOBS_SUFFIX "
	fi
}
