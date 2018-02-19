#!/bin/bash

# edit this as necessary for your system, BAT0 is another common directory
BATT_PATH="/sys/class/power_supply/BATT" 


function battery () {

	# sometimes this file reads 0 if the power source recently changed
	# which would be fine, except it causes a divide-by-zero error later on	
	# so I just let it sleep and that usually fixes the problem *shrug*
	if [ "$(cat $BATT_PATH/power_now)" -eq "0" ] ; then
		echo "(Power source recently changed...)"
		sleep 2
	fi

	BATT_DATA="$(cat $BATT_PATH/energy_now) / $(cat $BATT_PATH/power_now)"
	BATT_DATA="$(echo "scale=8; $BATT_DATA" | bc)"
	
	echo -n "$(cat $BATT_PATH/status) $(cat $BATT_PATH/capacity)% " 

	BATT_HOUR="$(echo "$BATT_DATA" | cut -d'.' -f1)"
	BATT_MINS="$(echo ".$(echo "$BATT_DATA" | cut -d'.' -f2) * 60" | bc | cut -d'.' -f1 | cut -b 1,2)"
	printf "(%02d:%02d remaining)\n" "$BATT_HOUR" "$BATT_MINS" 	
}
