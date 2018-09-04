#!/bin/bash

# gpg --detach-sign Ctlos.iso

USER="st"
iso_name=ctlos
iso_de=mini
iso_version=$(date +%Y%m%d)

if [[ $EUID -ne 0 ]]; then
  	echo "This script must be run as root" 
		exit 1
fi

ISO="${iso_name}_${iso_de}_${iso_version}.iso"

#Build ISO File
package=archiso
if pacman -Qs $package > /dev/null ; then
    echo "The package $package is installed"
else
    echo "Installing package $package"
    pacman -S $package --noconfirm
fi

source build.sh -v

chown $USER out/
cd out/

#create md5sum, sha256, sig
echo "create MD5, SHA-256 Checksum, sig"
sudo -u $USER md5sum $ISO >> $ISO.md5sum.txt
sudo -u $USER shasum -a 256 $ISO >> $ISO.sha256.txt
sudo -u $USER gpg --detach-sign --no-armor $ISO
