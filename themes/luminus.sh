#!/usr/bin/env bash

function wish_luminous_theme {
	local i
	local gradient=(ef7126 f7894c fea16f ffb892 ffd0b5 ffe7da ffffff)
	local fg_gradient=(000000 000000 000000 000000 000000 000000 000000)
	local j=0
	for i in "${WISH_PLUGINS[@]}"; do
		[[ $i =~ newline$ ]] && j=0 && continue
		declare "WISH_${i^^}_FG=${fg_gradient[$j]}"
		declare "WISH_${i^^}_BG=${gradient[$j]}"
		((j++))
		if [[ $j -eq ${#gradient[@]} ]]; then
			j=0
		fi
	done

	j=0
	for ((idx=$((${#WISH_RIGHT_PLUGINS[@]} - 1)); idx >= 0; idx--)); do
		i=${WISH_RIGHT_PLUGINS[$idx]}
		[[ $i =~ newline$ ]] && j=0 && continue
		declare "WISH_${i^^}_BG=${gradient[$j]}"
		declare "WISH_${i^^}_FG=${fg_gradient[$j]}"
		((j++))
		if [[ $j -eq ${#gradient[@]} ]]; then
			j=0
		fi
	done
}

wish_luminous_theme
