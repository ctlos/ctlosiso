#!/bin/bash

# gpg --detach-sign ctlos.iso
# gpg --verify ctlos.iso.sig ctlos.iso

iso_name=ctlos
iso_de=$1
iso_version=$(date +%Y%m%d)
script_path=$(realpath -- ${0%/*})

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

img_name="${iso_name}_${iso_de}_${iso_version}.iso"

#Build ISO File
build_iso() {
  pacman -Scc --noconfirm --quiet
  rm -rf /var/cache/pacman/pkg/*
  pacman-key --init
  pacman-key --populate
  pacman -Syy --quiet

  source $script_path/mkarchiso -v $script_path
}

# create md5sum, sha256, sig
check_sums() {
  cd out/
  echo "create MD5, SHA-256 Checksum, sig"
  # md5sum $img_name >> $img_name.md5.txt
  shasum -a 256 $img_name >> $img_name.sha256.txt
  # sudo -u ${SUDO_UID} gpg --detach-sign --no-armor $img_name
  cd ..
  chown -R "${SUDO_UID}:${SUDO_GID}" $script_path/out
}

run_qemu() {
  qemu-system-x86_64 -m 2G -boot d -enable-kvm -cdrom $script_path/out/$img_name
}

build_iso
check_sums
# run_qemu
