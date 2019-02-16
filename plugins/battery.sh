function wish_battery_start() {
	return 0
}

function wish_battery_end() {
	return 0
}

function wish_battery_set_colors() {
	WISH_BATTERY_FG=${WISH_BATTERY_FG:-$WISH_DEFAULT_FG}
	WISH_BATTERY_BG=${WISH_BATTERY_BG:-$WISH_DEFAULT_BG}
	WISH_BATTERY_ID=${WISH_BATTERY_ID:-BAT0}
	WISH_BATTERY_CHARGING=${WISH_BATTERY_CHARGING:-⌁}
	WISH_BATTERY_DISCHARGING=${WISH_BATTERY_DISCHARGING:-⏚}
}

function wish_battery_main() {
	local path=/sys/class/power_supply/$WISH_BATTERY_ID
	local battery=$(($(cat $path/charge_now) * 100 / $(cat $path/charge_full)))%
	if [[ $(cat $path/status) == "Charging" ]]; then
		battery="$WISH_BATTERY_CHARGING $battery"
	else
		battery="$WISH_BATTERY_DISCHARGING $battery"
	fi
	wish_append $WISH_BATTERY_BG $WISH_BATTERY_FG " $battery "
}
