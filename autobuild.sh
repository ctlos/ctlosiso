#!/usr/bin/env bash

# gpg --detach-sign ctlos.iso
# gpg --verify ctlos.iso.sig ctlos.iso

isode_ver=$1

iso_name=ctlos
iso_version=$(date +%Y%m%d)
script_path=$(realpath -- ${0%/*})

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

archiso_ver=$(pacman -Sl | grep "\ archiso" | awk '{print $3}')
sed -i "s/Archiso version:.*/Archiso version: $archiso_ver/" $script_path/README.md

img_name="${iso_name}_${isode_ver}_${iso_version}.iso"
sed -i "s/img_name=.*/img_name=\"$img_name\"/" $script_path/profiledef.sh

#Build ISO File
build_iso() {
  pacman -Scc --noconfirm --quiet
  rm -rf /var/cache/pacman/pkg/*
  pacman-key --init
  pacman-key --populate
  pacman -Syy --quiet

  [[ $(grep chroot.sh $script_path/mkarchiso.sh) ]] || \
  sed -i "/_mkairootfs_squashfs()/a [[ -e "$\{profile\}/chroot.sh" ]] && $\{profile\}/chroot.sh" $script_path/mkarchiso.sh

  $script_path/mkarchiso.sh -v $script_path
}

# create md5sum, sha256, sig
check_sums() {
  if [[ -e "$script_path/out/$img_name" ]]; then
    cd out/
    echo "create MD5, SHA-256 Checksum, sig"
    # md5sum $img_name >> $img_name.md5.txt
    sha256sum $img_name >> $img_name.sha256.txt
    # sudo -u ${SUDO_UID} gpg --detach-sign --no-armor $img_name
    cd ..
    chown -R "${SUDO_UID}:${SUDO_GID}" $script_path/out
  fi
}

run_qemu() {
  qemu-system-x86_64 -m 2G -boot d -enable-kvm -cdrom $script_path/out/$img_name
}

build_iso
check_sums
# run_qemu
