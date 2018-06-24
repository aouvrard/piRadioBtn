### UPDATE 06-2018
After many trouble with button management, I try install with just mpd (many mpc client are available on smartphone).

1. Config post-install : configure tzdata locales network and force jack audio output
```console
root@raspberrypi:/home/pi# raspi-config
```
2. Update, upgrade and install mpd
```console
root@raspberrypi:/home/pi# apt update && apt upgrade -y && apt install mpc mpd && systemctl enable mpd
```
3. Add your radio link on new file:
```console
root@raspberrypi:/home/pi# nano /var/lib/mpd/playlists/radios.m3u
```
for exemple
```txt
#France Inter
https://chai5she.cdn.dvmr.fr/franceinter-midfi.mp3
#Sing-Sing
http://stream.sing-sing.org:8000/singsing128
```
4. Ajust sound volume (100%)<br/>
`alsamixer`
5. Create bash script who autoplay radios on boot
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
6. Add crontab
```console
pi@raspberrypi:~ $ crontab -e
```
```bash
@reboot sh /home/pi/autoplay.sh &
```
