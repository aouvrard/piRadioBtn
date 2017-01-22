This project contain files to transform raspbian on web radio player with one button to manage.

#Installation
- Start from raspbian jessie 8
- Add a simple push button on GPIO number 24.
- Install mpd `apt install mpd mpc`
- Copy/Paste btn_track.sh script in $HOME
- Create mpc.service
`sudo nano /etc/systemd/system/mpc.service`

#Tricks
- To speedup boot time, try to disable dhcp at boot and configure a static IP for rasp
`cat /etc/network/interfaces`


> \#iface eth0 inet manual <br>
> auto eth0 <br>
> iface eth0 inet static <br> 
>  address 192.168.1.30 <br>
>  netmask 255.255.255.0 <br>
>  network 192.168.1.0 <br>
>  broadcast 192.168.1.255 <br>
>  gateway 192.168.1.254 <br>
>  dns-nameservers 91.121.161.184 188.165.197.144