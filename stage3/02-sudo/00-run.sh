#!/bin/bash -e

install -v -d					"${ROOTFS_DIR}/etc/ufw"
install -v -m 644 files/010_pi-nopasswd		"${ROOTFS_DIR}/etc/sudoers.d/"
