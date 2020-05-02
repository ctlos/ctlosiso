#!/bin/bash

script_path=$(readlink -f ${0%/*})
work_dir=work

arch_chroot(){
   arch-chroot $script_path/${work_dir}/airootfs /bin/bash -c "${1}"
}

chroo_ter(){
arch_chroot "pacman-key --init
pacman-key --add /usr/share/pacman/keyrings/ctlos.gpg
pacman-key --lsign-key 50417293016B25BED7249D8398F76D97B786E6A3
pacman-key --populate archlinux ctlos
pacman-key --refresh-keys
reflector --verbose -a1 -f10 -l70 -p https -p http --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy"
}

# sed -i 's?GRUB_DISTRIBUTOR=.*?GRUB_DISTRIBUTOR=\"Ctlos\"?' /etc/default/grub
# sed -i 's?\#GRUB_THEME=.*?GRUB_THEME=\/boot\/grub\/themes\/crimson\/theme.txt?g' /etc/default/grub
# echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
# wget https://github.com/ctlos/install_sh/raw/master/cleaner.sh
# chmod +x cleaner.sh
# mv cleaner.sh /usr/bin/

chroo_ter
