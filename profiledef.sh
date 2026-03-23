#!/usr/bin/env bash

iso_name="ctlos"
iso_version="$(date +%Y%m%d)"
image_name="ctlos_v2.4.9_20260323.iso"
iso_label="CTLOS_$(date +%Y%m)"
iso_publisher="Ctlos Linux <https://ctlos.github.io>"
iso_application="Ctlos Linux Live CD"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/gshadow"]="0:0:0400"
  ["/etc/shadow"]="0:0:400"
  ["/etc/sudoers.d"]="0:0:750"
  ["/etc/polkit-1"]="0:0:750"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/root/customize_airootfs.sh"]="0:0:755"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  # ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/cleaner.sh"]="0:0:755"
  ["/usr/local/bin/multilock.sh"]="0:0:755"
  ["/usr/local/bin/show_desktop"]="0:0:755"
  ["/usr/local/bin/ctlos-system"]="0:0:755"
)