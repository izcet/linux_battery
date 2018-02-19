## linux laptop battery function
![screenshot](assets/screenshot.png?raw=true "This is a Screenshot. There are many like it, but this one is mine.")
<br>
To use this function, add the following line to your `.*rc` (I use `.bashrc`, the syntax may need to be changed for other shells).
```
source /path/to/this/repo/battery.sh
```
#### About
 - The output format is `<battery status> <capacity percentage> (HH:MM remaining)`
 - This shell function reads the system files from `/sys/class/power_supply/...` and does some math and text manipulation to provide human readable output on various battery statistics.
 - The time is most accurate when the power source is the battery and not the charger.
 - The time calculation is based on your current power usage, so it will appear to suddenly have more battery life if you stop a lot of processes (as you would expect).
 - The script is protected against a divide-by-zero error when the power source changes while the script is running.
 - THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED. (MIT)
<br><br>
