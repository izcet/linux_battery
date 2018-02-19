#!/bin/bash

# This location works for Debian 9.
# I could put a little switch statement here for the appropriate OS path,
# but that's more overhead. Open an issue and I can add your OS.
# Until then, edit this as necessary for your system.
BATT_PATH="/sys/class/power_supply/BATT" 

function battery () {

	# Sometimes this file reads 0 if the power source recently changed,
	# which causes a divide-by-zero error later on.
	# Slowing so the system can catch up usually avoids the problem.
	if [ "$(cat $BATT_PATH/power_now)" -eq "0" ] ; then
		echo "(Power source recently changed...)"
		sleep 2
	fi

	# Acquire the values for the calculation and prepare.
	BATT_DATA="$(cat $BATT_PATH/energy_now) / $(cat $BATT_PATH/power_now)"
	# Perform the calculation, precision to 4 decimal places.
	BATT_DATA="$(echo "scale=4; $BATT_DATA" | bc)"

	# The calculation provides the time remaining in hours,
	# so we only need to truncate the decimal for output.
	BATT_HOUR="$(echo "$BATT_DATA" | cut -d'.' -f1)"

	# Prepare the conversion from decimal hours to minutes
	BATT_MINS="$(echo ".$(echo "$BATT_DATA" | cut -d'.' -f2) * 60")"
	# Perform the calculation and cut out the remainder.
	BATT_MINS="$(echo "$BATT_MINS" | bc | cut -d'.' -f1 | cut -b 1,2)"
	
	# I could repeat and provide the amount of seconds,
	# but because the time remaining is so variable,
	# that level of precision isn't necessary.

	# Output the easy statistics.
	echo -n "$(cat $BATT_PATH/status) $(cat $BATT_PATH/capacity)% " 
	# Output the calculations.
	printf "(%02d:%02d remaining)\n" "$BATT_HOUR" "$BATT_MINS" 	
}
