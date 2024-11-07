#!/usr/bin/env bash

function wish_icy_candy_theme {
	local i
	local l_gradient=(f5a9b8 f6b7c3 f8c5cf fad4db fbe2e7 fdf0f3 ffffff)
	local r_gradient=(5bcefa 76d6fa 91defb ade6fc c8eefd e3f6fe ffffff)
	local fg_gradient=(000000 000000 000000 000000 000000 000000 000000)
	local j=0
	for i in "${WISH_PLUGINS[@]}"; do
		[[ $i =~ newline$ ]] && j=0 && continue
		declare "WISH_${i^^}_FG=${fg_gradient[$j]}"
		declare "WISH_${i^^}_BG=${l_gradient[$j]}"
		((j++))
		if [[ $j -eq ${#l_gradient[@]} ]]; then
			j=0
		fi
	done

	j=0
	for ((idx=$((${#WISH_RIGHT_PLUGINS[@]} - 1)); idx >= 0; idx--)); do
		i=${WISH_RIGHT_PLUGINS[$idx]}
		[[ $i =~ newline$ ]] && j=0 && continue
		declare "WISH_${i^^}_BG=${r_gradient[$j]}"
		declare "WISH_${i^^}_FG=${fg_gradient[$j]}"
		((j++))
		if [[ $j -eq ${#r_gradient[@]} ]]; then
			j=0
		fi
	done
}

wish_icy_candy_theme
