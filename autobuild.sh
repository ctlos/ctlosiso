#!/bin/bash

# gpg --detach-sign Ctlos.iso

# $whoami && $LOGNAME
USER=$(whoami)
iso_name=ctlos
iso_de=$1
iso_version=$2_$(date +%Y%m%d)

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

ISO="${iso_name}_${iso_de}_${iso_version}.iso"

#Build ISO File
build_iso(){
  package=archiso
  if pacman -Qs $package > /dev/null ; then
    echo "The package $package is installed"
  else
    echo "Installing package $package"
    pacman -S $package --noconfirm
  fi

  source build.sh -v
}

#create md5sum, sha256, sig
check_sums() {
  chown $USER out/
  cd out/
  echo "create MD5, SHA-256 Checksum, sig"
  sudo -u $USER md5sum $ISO >> $ISO.md5sum.txt
  sudo -u $USER shasum -a 256 $ISO >> $ISO.sha256.txt
  # sudo -u $USER gpg --detach-sign --no-armor $ISO
}

run_qemu()
{
  qemu-system-x86_64 -m 2048 -cdrom $ISO
}

build_iso
check_sums
# run_qemu
