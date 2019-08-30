#!/bin/bash -e

install -v -d					"${ROOTFS_DIR}/etc/ufw"
install -v -m 644 files/ufw.conf		"${ROOTFS_DIR}/etc/ufw/"

install -v -m 640 files/user.rules		"${ROOTFS_DIR}/etc/ufw/"
install -v -m 640 files/user6.rules		"${ROOTFS_DIR}/etc/ufw/"

# NOTE: install basic rules and enable iptables
echo "Configure firewall"
install -m 755 files/ufw_default_deny_out       ${ROOTFS_DIR}/etc/init.d/
install -m 755 files/deny_default_out.sh    ${ROOTFS_DIR}/usr/bin/
chmod +x ${ROOTFS_DIR}/etc/init.d/ufw_default_deny_out
chmod +x ${ROOTFS_DIR}/usr/bin/deny_default_out.sh

on_chroot << EOF
  systemctl enable ufw_default_deny_out
EOF

