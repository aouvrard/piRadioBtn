#!/bin/bash

#Set GPIO ID with push button
GPIO_ID="24"

#Initialize GPIO
echo $GPIO_ID > /sys/class/gpio/export
echo in > /sys/class/gpio/gpio$GPIO_ID/direction

#Start MPC
mpc clear
mpc load radios
mpc repeat on
mpc play

printf "MPC started"

i=0
echo "Loop check push"
while :
do
    until /bin/grep 1 /sys/class/gpio/gpio$GPIO_ID/value >> /dev/null
    do
        /bin/sleep .1
    done

    let i++
    if [ $i -ge 30 ]
        then
        printf "Shutdown by button"
        sudo systemctl poweroff
        break
    fi

    echo "Next Track"
    mpc next
done
