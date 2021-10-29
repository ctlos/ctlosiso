#!/usr/bin/env bash
set -e -u

script_path=$(readlink -f ${0%/*})
work_dir=${script_path}/work/x86_64/airootfs

echo "==== create settings.sh ===="
sed '1,/^#chroot$/d' ${script_path}/chroot.sh >${work_dir}/settings.sh

chrooter() {
  arch-chroot ${work_dir} /bin/bash -c "${1}"
}

chmod +x ${work_dir}/settings.sh
chrooter /settings.sh
rm ${work_dir}/settings.sh
exit 0

#chroot
isouser="liveuser"
OSNAME="ctlos"

_conf() {
  ln -sf /usr/share/zoneinfo/UTC /etc/localtime
  hwclock --systohc --utc
  sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
  sed -i "s/#\(ru_RU\.UTF-8\)/\1/" /etc/locale.gen
  locale-gen
  echo "LANG=ru_RU.UTF-8" > /etc/locale.conf
  echo "LC_COLLATE=C" >> /etc/locale.conf
  echo "KEYMAP=ru" > /etc/vconsole.conf
  echo "FONT=cyr-sun16" >> /etc/vconsole.conf
  echo "$OSNAME" > /etc/hostname
  export _BROWSER=firefox
  echo "BROWSER=/usr/bin/${_BROWSER}" >> /etc/environment
  export _EDITOR=nano
  echo "EDITOR=${_EDITOR}" >> /etc/environment
  echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment
  sed -i '/User/s/^#\+//' /etc/sddm.conf
}

_perm() {
  mkdir -p /media
  chmod 755 -R /media
  chmod +x /usr/local/bin/*
  # chmod +x /etc/skel/.bin/*
  # chmod +x /home/$isouser/.bin/*
  # find /etc/skel/ -type f -iname "*.sh" -exec chmod +x {} \;
  # find /home/$isouser/ -type f -iname "*.sh" -exec chmod +x {} \;
}

_liveuser() {
  glist="audio,disk,log,network,scanner,storage,power,wheel"
  if ! id $isouser 2>/dev/null; then
    useradd -m -p "" -c "Liveuser" -g users -G $glist -s /usr/bin/zsh $isouser
    echo "$isouser ALL=(ALL) ALL" >> /etc/sudoers
  fi
}

_font() {
  rm -rf /etc/fonts/conf.d/10-scale-bitmap-fonts.conf
}

_nm() {
  echo "" > /etc/NetworkManager/NetworkManager.conf
  echo "[device]" >> /etc/NetworkManager/NetworkManager.conf
  echo "wifi.scan-rand-mac-address=no" >> /etc/NetworkManager/NetworkManager.conf
  echo "" >> /etc/NetworkManager/NetworkManager.conf
  echo "[main]" >> /etc/NetworkManager/NetworkManager.conf
  echo "dhcp=dhclient" >> /etc/NetworkManager/NetworkManager.conf
  echo "dns=systemd-resolved" >> /etc/NetworkManager/NetworkManager.conf
}

_key() {
  reflector -a 12 -l 15 -p https,http --sort rate --save /etc/pacman.d/mirrorlist
  pacman-key --init
  pacman-key --populate
  pacman -Syy --noconfirm
}

_drsed() {
  sed -i /etc/lsb-release \
    -e 's,DISTRIB_ID=.*,DISTRIB_ID=Ctlos,' \
    -e 's,DISTRIB_RELEASE=.*,DISTRIB_RELEASE=Rolling,' \
    -e 's,DISTRIB_CODENAME=.*,DISTRIB_CODENAME=Anon,' \
    -e 's,DISTRIB_DESCRIPTION=.*,DISTRIB_DESCRIPTION=\"Ctlos Linux\",'

  sed -i /usr/lib/os-release \
    -e 's,NAME=.*,NAME=\"Ctlos Linux\",' \
    -e 's,PRETTY_NAME=.*,PRETTY_NAME=\"Ctlos Linux\",' \
    -e 's,ID=.*,ID=ctlos,' \
    -e 's,ID_LIKE=.*,ID_LIKE=arch,' \
    -e 's,BUILD_ID=.*,BUILD_ID=rolling,' \
    -e 's,HOME_URL=.*,HOME_URL=\"https://ctlos.github.io\",' \
    -e 's,DOCUMENTATION_URL=.*,DOCUMENTATION_URL=\"https://ctlos.github.io/wiki\",' \
    -e 's,SUPPORT_URL=.*,SUPPORT_URL=\"https://forum.ctlos.ru\",' \
    -e 's,BUG_REPORT_URL=.*,BUG_REPORT_URL=\"https://github.com/ctlos/ctlosiso/issues\",' \
    -e 's,LOGO=.*,LOGO=ctlos,'

  sed -i 's|Arch|Ctlos|g' /etc/issue /usr/share/factory/etc/issue
}

_serv() {
  systemctl mask systemd-rfkill@.service
  systemctl mask systemd-rfkill.socket
  systemctl enable haveged.service
  systemctl enable pacman-init.service
  systemctl enable choose-mirror.service
  systemctl enable vbox-check.service
  # systemctl enable avahi-daemon.service
  # systemctl enable systemd-networkd.service
  # systemctl enable systemd-resolved.service
  # systemctl enable systemd-timesyncd.service
  systemctl enable ModemManager.service
  systemctl -f enable NetworkManager.service
  # systemctl enable iwd.service
  systemctl enable reflector.service
  systemctl enable sshd.service
  systemctl enable sddm.service
  systemctl set-default graphical.target
}

_conf
_perm
# _liveuser
# _font
_nm
_key
_drsed
# _serv

# sed -i 's?GRUB_DISTRIBUTOR=.*?GRUB_DISTRIBUTOR=\"Ctlos\"?' /etc/default/grub
# sed -i 's?\#GRUB_THEME=.*?GRUB_THEME=\/boot\/grub\/themes\/crimson\/theme.txt?g' /etc/default/grub
# echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
# wget https://github.com/ctlos/ctlos-sh/raw/master/cleaner.sh
# chmod +x cleaner.sh
# mv cleaner.sh /usr/local/bin/

echo "==== Done settings.sh ===="
