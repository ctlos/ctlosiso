#!/bin/bash

# gpg --detach-sign ctlos.iso
# gpg --verify ctlos.iso.sig ctlos.iso

user_name=st
iso_name=ctlos
iso_de=$1
iso_version=$(date +%Y%m%d)
script_path=$(readlink -f ${0%/*})

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

img_name="${iso_name}_${iso_de}_${iso_version}.iso"

#Build ISO File
build_iso(){
  package=archiso
  if pacman -Qs $package > /dev/null ; then
    echo "The package $package is installed"
  else
    echo "Installing package $package"
    pacman -S $package --noconfirm
  fi

  pacman -Scc --noconfirm --quiet
  rm -rf /var/cache/pacman/pkg/*
  pacman-key --init
  pacman-key --populate
  pacman -Syy --quiet

  source $script_path/mkarchiso -v $script_path
}

#create md5sum, sha256, sig
check_sums() {
  chown -R $user_name out/
  cd out/
  echo "create MD5, SHA-256 Checksum, sig"
  sudo -u $user_name md5sum $img_name >> $img_name.md5.txt
  sudo -u $user_name shasum -a 256 $img_name >> $img_name.sha256.txt
  # sudo -u $user_name gpg --detach-sign --no-armor $img_name
}

run_qemu()
{
  qemu-system-x86_64 -m 2G -boot d -enable-kvm -cdrom $img_name
}

build_iso
check_sums
# run_qemu
