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
echo "Loop"
while true
do
        echo "Until"
        until /bin/grep 1 /sys/class/gpio/gpio$GPIO_ID/value >> /dev/null
        do
                /bin/sleep .1
        done
        echo "End until"
        i=$((i+1))
        if [ $i -ge 30 ]
                then

                sudo systemctl poweroff
                echo "Shutdown..."
                break
        fi

        echo "Next Track"
        /usr/bin/mpc next
done
echo "End loop"