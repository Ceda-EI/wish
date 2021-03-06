function wish_vcs_start() {
	return 0
}

function wish_vcs_end() {
	return 0
}

function wish_vcs_set_colors() {
	WISH_VCS_FG=${WISH_VCS_FG:-$WISH_DEFAULT_FG}
	WISH_VCS_BG=${WISH_VCS_BG:-$WISH_DEFAULT_BG}
	WISH_VCS_GIT_SYMBOL=${WISH_VCS_GIT:-}
	[[ -v WISH_VCS_DEFAULT ]] || WISH_VCS_DEFAULT="$"
	WISH_VCS_GIT_UNTRACKED_SYMBOL=${WISH_VCS_GIT_UNTRACKED_SYMBOL:-●}
}

function wish_vcs_main() {
	local op=$(git diff --numstat 2> /dev/null || echo -1)
	if [[ $op != "-1" ]]; then
		local git
		git="$git $WISH_VCS_GIT_SYMBOL "
		git="$git$(git branch | grep -F \* | sed 's/\* //') "

		if [[ $(git status --porcelain 2> /dev/null | grep "^??")  != "" ]]; then
			git="$git$WISH_VCS_GIT_UNTRACKED_SYMBOL "
		fi

		local add=$(echo "$op" | awk '{a += $1} END {print a}')
		local del=$(echo "$op" | awk '{d += $2} END {print d}')
		if [[ $add != 0 ]] || [[ $del != 0 ]]; then
			git="$git+$add -$del "
		fi
		wish_append $WISH_VCS_BG $WISH_VCS_FG "$git"
	else
		wish_append $WISH_VCS_BG $WISH_VCS_FG "$WISH_VCS_DEFAULT"
	fi
}

