function wish_tmux_start() {
	return 0
}

function wish_tmux_end() {
	return 0
}

function wish_tmux_set_colors() {
	WISH_TMUX_FG=${WISH_TMUX_FG:-$WISH_DEFAULT_FG}
	WISH_TMUX_BG=${WISH_TMUX_BG:-$WISH_DEFAULT_BG}
	WISH_TMUX_SUFFIX=${WISH_TMUX_SUFFIX:-d}
}

function wish_tmux_main() {
	local s=`tmux list-sessions 2>/dev/null | grep -vE "\(attached\)$" | wc -l`
	if [[ $s -eq 0 ]]; then
		wish_append $WISH_TMUX_BG $WISH_TMUX_FG $tmux
	else
		wish_append $WISH_TMUX_BG $WISH_TMUX_FG " $s$WISH_TMUX_SUFFIX "
	fi
}
