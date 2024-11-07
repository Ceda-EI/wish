WISH_DEFAULT_BG=-1
WISH_DEFAULT_FG=-1
WISH_POWERLINE=0
for i in ${WISH_PLUGINS[@]} ${WISH_RIGHT_PLUGINS[@]}; do
	declare WISH_${i^^}_BG=-1
	declare WISH_${i^^}_FG=-1
done
