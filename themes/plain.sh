WISH_DEFAULT_BG=-1
WISH_DEFAULT_FG=-1
WISH_POWERLINE=0
for i in ${WISH_PLUGINS[@]}; do
	eval WISH_$(echo $i | tr '[:lower:]' '[:upper:]')_BG=-1
	eval WISH_$(echo $i | tr '[:lower:]' '[:upper:]')_FG=-1
done
