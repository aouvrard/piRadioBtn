This project contain files to transform raspbian on web radio player with one button to manage.

#Installation
- Start from raspbian jessie 8
- Add a simple push button on GPIO number 24.
- Install mpd `apt install mpd mpc`
- Copy/Paste btn_track.sh script in $HOME
- Create mpc.service
`sudo nano /etc/systemd/system/mpc.service`
