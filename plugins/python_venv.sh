function wish_python_venv_start() {
	return 0
}

function wish_python_venv_end() {
	return 0
}

function wish_python_venv_set_colors() {
	WISH_PYTHON_VENV_FG=${WISH_PYTHON_VENV_FG:-$WISH_DEFAULT_FG}
	WISH_PYTHON_VENV_BG=${WISH_PYTHON_VENV_BG:-$WISH_DEFAULT_BG}
}

function wish_python_venv_main() {
	if [[ -v VIRTUAL_ENV ]]; then
		local venv=$(echo $VIRTUAL_ENV | sed ';s|/.venv$||;s|.*/||')
		wish_append $WISH_PYTHON_VENV_BG $WISH_PYTHON_VENV_FG " $venv "
	else
		wish_append $WISH_PYTHON_VENV_BG $WISH_PYTHON_VENV_FG ""
	fi
}
