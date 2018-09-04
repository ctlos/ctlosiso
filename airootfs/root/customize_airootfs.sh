#!/bin/bash

USER="liveuser"
OSNAME="Ctlos"


function umaskFix() {
    set -e -u
    umask 022
}

function localeGen() {
    sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
    sed -i "s/#\(ru_RU\.UTF-8\)/\1/" /etc/locale.gen
    locale-gen
}

function setTimeZoneAndClock() {
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime
    hwclock --systohc --utc
}

function editOrCreateConfigFiles() {
    # Locale
    echo "LANG=ru_RU.UTF-8" > /etc/locale.conf
    echo "LC_COLLATE=C" >> /etc/locale.conf

    # Vconsole
    echo "KEYMAP=ru" > /etc/vconsole.conf
    echo "FONT=cyr-sun16" >> /etc/vconsole.conf

    # Hostname
    echo "ctlos" > /etc/hostname

    sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
    sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf
}

function configRootUser() {
    usermod -s /usr/bin/zsh root
    chmod 700 /root
}

function createLiveUser() {
    # add groups autologin and nopasswdlogin (for lightdm autologin)
    groupadd -r autologin
    groupadd -r nopasswdlogin

    # add liveuser
    id -u $USER &>/dev/null || useradd -m $USER -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,autologin,nopasswdlogin,power,wheel" -s /usr/bin/zsh
    passwd -d $USER
    echo "liveuser ALL=(ALL) ALL" >> /etc/sudoers
    echo 'Live User Created'
}

function setDefaults() {
    export _BROWSER=chromium
    echo "BROWSER=/usr/bin/${_BROWSER}" >> /etc/environment
    echo "BROWSER=/usr/bin/${_BROWSER}" >> /etc/profile

    export _EDITOR=nano
    echo "EDITOR=${_EDITOR}" >> /etc/environment
    echo "EDITOR=${_EDITOR}" >> /etc/profile

    # default shell
    # chsh -s /bin/bash
    chsh -s /bin/zsh

    # fix qt5
    echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment
}

function addCalamares() {
    mkdir /home/liveuser/.config/autostart
    cp -v /usr/share/applications/calamares.desktop /home/liveuser/.config/autostart/calamares.desktop
    chown liveuser:wheel /home/liveuser/.config/autostart/calamares.desktop
    chmod +x /home/liveuser/.config/autostart/calamares.desktop
}

function fontFix() {
    # https://wiki.archlinux.org/index.php/font_configuration
    rm -rf /etc/fonts/conf.d/10-scale-bitmap-fonts.conf
}

function fixWifi() {
    #https://wiki.archlinux.org/index.php/NetworkManager#Configuring_MAC_Address_Randomization
    su -c 'echo "" >> /etc/NetworkManager/NetworkManager.conf'
    su -c 'echo "[device]" >> /etc/NetworkManager/NetworkManager.conf'
    su -c 'echo "wifi.scan-rand-mac-address=no" >> /etc/NetworkManager/NetworkManager.conf'
}

function fixPermissions() {
    #add missing /media directory
    mkdir -p /media
    chmod 755 -R /media

    #fix permissions
    chown root:root /
    chown root:root /etc
    chown root:root /etc/default
    chown root:root /usr
    chmod 755 /etc

    #enable sudo
    chmod 750 /etc/sudoers.d
    chmod 440 /etc/sudoers.d/g_wheel
    chown -R root /etc/sudoers.d
    chmod -R 755 /etc/sudoers.d
}

function fixHibernate() {
    sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
    sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
    sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf
}

function removingPackages() {
    pacman -R --noconfirm go
}

function fixHaveged(){
    systemctl start haveged
    systemctl enable haveged

    rm -fr /etc/pacman.d/gnupg
}

function initkeys() {
    pacman-key --init
    pacman-key --populate archlinux
    pacman -Syy --noconfirm
}

function enableServices() {
    systemctl enable avahi-daemon.service
    systemctl enable vboxservice.service
    systemctl enable ntpd.service
    systemctl enable lightdm.service
    systemctl enable NetworkManager.service
    systemctl -fq enable NetworkManager-wait-online.service
    systemctl mask systemd-rfkill@.service
    systemctl mask systemd-rfkill.service
    systemctl mask systemd-rfkill.socket
    systemctl enable pacman-init.service
    systemctl enable choose-mirror.service
    systemctl set-default graphical.target
}


umaskFix
localeGen
setTimeZoneAndClock
editOrCreateConfigFiles
configRootUser
createLiveUser
setDefaults
addCalamares
fontFix
fixWifi
fixPermissions
fixHibernate
removingPackages
fixHaveged
initkeys
enableServices
