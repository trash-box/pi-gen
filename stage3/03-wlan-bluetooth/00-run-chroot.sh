#!/bin/bash -e

(echo "@reboot sleep 15 && sudo iwconfig wlan0 txpower off") | crontab -

apt purge bluez -y
apt autoremove -y
