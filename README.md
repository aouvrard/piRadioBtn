## UPDATE 06-2018
After many trouble with button management, I try install with just mpd (many mpc client are available on smartphone).

### 1. Config raspbian 9 post-install : 
```console
root@raspberrypi:/home/pi# raspi-config
```
configure 
* tzdata
* locales 
* network 
* force audio output on jack and not hdmi
### 2. Update, upgrade and install mpd
```console
root@raspberrypi:/home/pi# apt update && apt upgrade -y && apt install mpc mpd && systemctl enable mpd
```
### 3. Add your radio link on new file:
```console
root@raspberrypi:/home/pi# nano /var/lib/mpd/playlists/radios.m3u
```
for example
```txt
#France Inter
https://chai5she.cdn.dvmr.fr/franceinter-midfi.mp3
#Sing-Sing
http://stream.sing-sing.org:8000/singsing128
```
### 4. Ajust sound volume
```console
pi@raspberrypi:~ $ alsamixer
```
put 100% !!!
### 5. Create bash script who autoplay radios on boot
```console
pi@raspberrypi:~ $ nano /home/pi/autoplay.sh
```
```bash
#!/bin/sh

if mpc status | awk 'NR==2' | grep playing; then
  echo "mpc déja lancé, je ne fait que passer..."
else
  echo "chargement des radios"
  mpc clear
  mpc load radios
  mpc play
fi
```
### 6. Add crontab
```console
pi@raspberrypi:~ $ crontab -e
```
```bash
@reboot sh /home/pi/autoplay.sh &
# France Inter tout les matins a 8h
00 08 * * * mpc play 1
# Sing-Sing le soir à 19h
10 19 * * * mpc play 2
```

To avoid write error on disk, restart mdp every day
```console
root@raspberrypi:~ $ crontab -e
```
```bash
00 04 * * * service mpd restart
```
