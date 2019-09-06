#!/usr/bin/env bash

local i
local gradient=(226 118 37 66 60 237 233)
local fg_gradient=(16 16 16 16 16 15 15)
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
