#!/usr/bin/env bash

WISH_POWERLINE=0
local i
local gradient=(e7c547 c0e551 82e35a 62e177 6bdfb3 73d4dd 7aa6da)
local j=0
for i in ${WISH_PLUGINS[@]}; do
	[[ $i == "newline" ]] && j=0 && continue
	eval WISH_${i^^}_BG=-1
	eval WISH_${i^^}_FG=${gradient[$j]}
	((j++))
	if [[ $j -eq ${#gradient[@]} ]]; then
		j=0
	fi
done
