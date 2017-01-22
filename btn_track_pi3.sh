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
        i=0
    done

    echo i=$i

    let i++
    if [ $i -ge 3 ]
        then
        printf "Shutdown by button"
        sudo systemctl poweroff
        break
    fi

    if [ $i -ge 1 ]
        then
        echo "Next Track"
        mpc next
        /bin/sleep .5
    fi
done

