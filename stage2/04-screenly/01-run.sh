#!/bin/bash -e

on_chroot << EOF
  curl -s https://bootstrap.pypa.io/get-pip.py | python3.5

  git clone https://github.com/trash-box/screenly-ose.git /home/pi/screenly
  cd /home/pi/screenly
  git checkout master

  python3.5 -m pip install -r requirements.txt
  mkdir -p /etc/ansible
  echo -e "[local]\nlocalhost ansible_connection=local" | tee /etc/ansible/hosts > /dev/null

  cd ansible
  HOME=/home/pi MANAGE_NETWORK=true ansible-playbook site.yml --skip-tags enable-ssl,disable-nginx,touches_boot_partition
  touch /home/pi/.screenly/initialized
  chown -R pi:pi /home/pi

  apt-get autoclean
  apt-get clean

  find /usr/share/doc -depth -type f ! -name copyright -delete
  find /usr/share/doc -empty -delete
  rm -rf /usr/share/man /usr/share/groff /usr/share/info /usr/share/lintian /usr/share/linda /var/cache/man
  find /usr/share/locale -type f ! -name 'en' ! -name 'de*' ! -name 'es*' ! -name 'ja*' ! -name 'fr*' ! -name 'zh*' -delete
  find /usr/share/locale -mindepth 1 -maxdepth 1 ! -name 'en*' ! -name 'de*' ! -name 'es*' ! -name 'ja*' ! -name 'fr*' ! -name 'zh*' -exec rm -r {} \;
EOF
