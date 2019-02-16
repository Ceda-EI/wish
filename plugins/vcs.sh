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
	WISH_VCS_DEFAULT=${WISH_VCS_DEFAULT:-$}
	WISH_VCS_GIT_UNTRACKED_SYMBOL=${WISH_VCS_GIT_UNTRACKED_SYMBOL:-●}
}

function wish_vcs_main() {
	local op=$(git diff --numstat HEAD 2> /dev/null)
	if [[ $op != "" ]]; then
		local git
		if [[ $(git status --porcelain 2> /dev/null | grep "^??")  != "" ]]; then
			local git=" $WISH_VCS_GIT_UNTRACKED_SYMBOL"
		fi
		git="$git $WISH_VCS_GIT_SYMBOL "
		git="$git$(git branch | grep -F \* | sed 's/\* //') "

		local add=$(echo "$op" | awk '{a += $1} END {print a}')
		local del=$(echo "$op" | awk '{d += $2} END {print d}')
		if [[ $add != 0 ]] && [[ $del != 0 ]]; then
			git="$git+$add -$del "
		fi
		wish_append $WISH_VCS_BG $WISH_VCS_FG "$git"
	else
		wish_append $WISH_VCS_BG $WISH_VCS_FG " $WISH_VCS_DEFAULT "
	fi
}

