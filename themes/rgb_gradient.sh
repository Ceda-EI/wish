#!/usr/bin/env bash

local i
local gradient=(ffff5f 7ad767 66b097 5e7388 534d61 3a3338 121212)
local fg_gradient=(000000 000000 000000 000000 000000 ffffff ffffff)
local j=0
for i in ${WISH_PLUGINS[@]}; do
	[[ $i == "newline" ]] && j=0 && continue
	eval WISH_${i^^}_BG=${gradient[$j]}
	eval WISH_${i^^}_FG=${fg_gradient[$j]}
	((j++))
	if [[ $j -eq ${#gradient[@]} ]]; then
		j=0
	fi
done
