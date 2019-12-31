function wish_custom_text_start() {
	return 0
}

function wish_custom_text_end() {
	return 0
}

function wish_custom_text_set_colors() {
	WISH_CUSTOM_TEXT_FG=${WISH_CUSTOM_TEXT_FG:-$WISH_DEFAULT_FG}
	WISH_CUSTOM_TEXT_BG=${WISH_CUSTOM_TEXT_BG:-$WISH_DEFAULT_BG}
	local default_text='To set custom text here, add text="your text" in your config'
	WISH_CUSTOM_TEXT_TEXT=${WISH_CUSTOM_TEXT:-$default_text}
}

function wish_custom_text_main() {
	wish_append $WISH_CUSTOM_TEXT_BG $WISH_CUSTOM_TEXT_FG "$WISH_CUSTOM_TEXT_TEXT"
}
