#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="ctlos"
iso_label="CTLOS_$(date +%Y%m)"
iso_publisher="Ctlos Linux <https://ctlos.github.io>"
iso_application="Ctlos Linux Live CD"
iso_version="$(date +%Y%m%d)"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
file_permissions=(
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/usr/local/bin/cleaner.sh"]="0:0:755"
  ["/usr/local/bin/vbox-check"]="0:0:755"
  ["/usr/local/bin/multilock.sh"]="0:0:755"
  ["/usr/local/bin/show_desktop"]="0:0:755"
)
