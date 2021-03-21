#!/bin/sh

echo "Use Ctrl+C to quit"

while true

do

echo "-----------------"

echo "CPU Freq: "

cpu_freq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq)
awk 'BEGIN{printf "%.d MHz\n",('$cpu_freq'/1000)}'
echo "SOC Temp: "

soc_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
awk 'BEGIN{printf "%.1f °C\n",('$soc_temp'/1000)}'

sleep 1

done
