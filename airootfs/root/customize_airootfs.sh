#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e -u
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
}

_perm() {
  mkdir -p /media
  chmod 755 -R /media
}

_root() {
  usermod -s /usr/bin/zsh root
}

_liveuser() {
  glist="audio,disk,log,network,scanner,storage,power,wheel"
  if ! id $isouser 2>/dev/null; then
    useradd -m -p "" -c "Liveuser" -g users -G $glist -s /usr/bin/zsh $isouser
    echo "$isouser ALL=(ALL) ALL" >> /etc/sudoers
  fi
}

_default() {
  export _BROWSER=firefox
  echo "BROWSER=/usr/bin/${_BROWSER}" >> /etc/environment
  echo "BROWSER=/usr/bin/${_BROWSER}" >> /etc/profile
  export _EDITOR=nano
  echo "EDITOR=${_EDITOR}" >> /etc/environment
  echo "EDITOR=${_EDITOR}" >> /etc/profile
  echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment
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

# _keys() {
#   pacman-key --init
#   # pacman-key --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys 98F76D97B786E6A3
#   # pacman-key --keyserver hkps://hkps.pool.sks-keyservers.net:443 --recv-keys 98F76D97B786E6A3
#   pacman-key --keyserver keys.gnupg.net --recv-keys 98F76D97B786E6A3
#   pacman-key --lsign-key 98F76D97B786E6A3
#   pacman-key --populate
#   pacman -Syy --noconfirm
# }

_serv() {
  # systemctl -fq enable NetworkManager.service
  systemctl mask systemd-rfkill@.service
  systemctl enable haveged.service
  systemctl enable pacman-init.service
  systemctl enable choose-mirror.service
  systemctl enable vbox-check.service
  # systemctl enable avahi-daemon.service
  systemctl enable systemd-networkd.service
  systemctl enable systemd-resolved.service
  systemctl enable systemd-timesyncd.service
  systemctl enable NetworkManager.service
  # systemctl enable iwd.service
  systemctl enable reflector.service
  systemctl enable sshd.service
  systemctl enable sddm.service
  systemctl set-default graphical.target
}

_conf
_perm
_root
_liveuser
_default
_font
_nm
# _keys
_serv
