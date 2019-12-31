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
	WISH_PATH_POWERLINE_MAX_PERC=${WISH_PATH_POWERLINE_MAX_PERC:-0}
}

function wish_path_lensum() {
	sum=0
	for i in $*; do
		sum=$(($sum + ${#i}))
	done
	echo $sum
}

function wish_path_powerline_shrink() {
	local IFS='/'
	local path=( $1 )
	local max=$(( $2 - 3 * ${#path[@]} ))
	for ((i=0; i <$((${#path[@]} - 1)); i++)); do
		path[$i]=${path[$i]:0:1}
		if [[ $(wish_path_lensum ${path[@]}) -lt $max ]]; then
			local short_path=""
			for i in ${path[@]}; do
				short_path+="$i/"
			done
			echo "${short_path%/}"
			return
		fi
	done
	local short_path=""
	for i in ${path[@]}; do
		short_path+="$i/"
	done
	echo "${short_path%/}"
}

function wish_path_powerline_main() {
	local path="${PWD/#$HOME/\~}"
	if [[ $WISH_PATH_POWERLINE_MAX_PERC -ne 0 && ${#path} -ge $WISH_PATH_POWERLINE_MAX_LEN ]] ; then
		local max=$(($WISH_PATH_POWERLINE_MAX_PERC * $(wish_remaining_chars) / 100))
		local path=$(wish_path_powerline_shrink "$path" "$max")
	fi
	local path="${path//\//  }"
	if [[ -w $PWD ]]; then
		local path=" $path "
	else
		local path=" $path$WISH_PATH_POWERLINE_NO_WRITE_SUFFIX "
	fi
	wish_append $WISH_PATH_POWERLINE_BG $WISH_PATH_POWERLINE_FG "$path"
}
