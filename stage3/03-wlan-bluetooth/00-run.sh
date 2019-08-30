#!/bin/bash -e

on_chroot << EOF
  ed -s /boot/config.txt <<< w
  echo "" | tee -a /boot/config.txt
  echo "# Disable WLAN for DPS" | tee -a /boot/config.txt
  echo "dtoverlay=pi3-disable-wifi" | tee -a /boot/config.txt

  apt purge bluez -y
  apt autoremove -y
EOF

