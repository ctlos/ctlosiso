#!/usr/bin/env bash

iso_name="ctlos"
iso_version="$(date +%Y%m%d)"
image_name="ctlos_v2.4.6_20240520.iso"
iso_label="CTLOS_$(date +%Y%m)"
iso_publisher="Ctlos Linux <https://ctlos.github.io>"
iso_application="Ctlos Linux Live CD"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/gshadow"]="0:0:600"
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/etc/polkit-1"]="0:0:750"
  ["/etc/sudoers.d"]="0:0:750"
  ["/usr/local/bin/cleaner.sh"]="0:0:755"
  ["/usr/local/bin/multilock.sh"]="0:0:755"
  ["/usr/local/bin/show_desktop"]="0:0:755"
  ["/usr/local/bin/ctlos-system"]="0:0:755"
)
