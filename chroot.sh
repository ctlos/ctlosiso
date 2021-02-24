#!/bin/bash

script_path=$(readlink -f ${0%/*})
work_dir=${script_path}/work/x86_64/airootfs

echo "==== create settings.sh ===="

cat <<LOL >${work_dir}/settings.sh
reflector -a 12 -l 30 -f 30 -p https --sort rate --save /etc/pacman.d/mirrorlist
pacman-key --init
pacman-key --populate
pacman -Syy --noconfirm

sed -i '/User/s/^#\+//' /etc/sddm.conf

lsb_release_sed() {
  sed -i /etc/lsb-release \
    -e 's,DISTRIB_ID=.*,DISTRIB_ID=Ctlos,' \
    -e 's,DISTRIB_RELEASE=.*,DISTRIB_RELEASE=Rolling,' \
    -e 's,DISTRIB_CODENAME=.*,DISTRIB_CODENAME=Anon,' \
    -e 's,DISTRIB_DESCRIPTION=.*,DISTRIB_DESCRIPTION=\"Ctlos Linux\",'
}

os_release_sed() {
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
}

issue_sed() {
  sed -i 's|Arch|Ctlos|g' /etc/issue /usr/share/factory/etc/issue
}
lsb_release_sed
os_release_sed
issue_sed


# sed -i 's?GRUB_DISTRIBUTOR=.*?GRUB_DISTRIBUTOR=\"Ctlos\"?' /etc/default/grub
# sed -i 's?\#GRUB_THEME=.*?GRUB_THEME=\/boot\/grub\/themes\/crimson\/theme.txt?g' /etc/default/grub
# echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
# wget https://github.com/ctlos/ctlos-sh/raw/master/cleaner.sh
# chmod +x cleaner.sh
# mv cleaner.sh /usr/local/bin/
LOL

chrooter() {
  arch-chroot ${work_dir} /bin/bash -c "${1}"
}

chmod +x ${work_dir}/settings.sh
chrooter /settings.sh
rm ${work_dir}/settings.sh

echo "==== Done settings.sh ===="
