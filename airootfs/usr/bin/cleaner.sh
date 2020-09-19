#!/bin/bash

clean_iso(){
  local files_rm=(
    /var/lib/NetworkManager/NetworkManager.state
    /etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount}
    /usr/local/bin/{choose-mirror,Installation_guide}
    /etc/ctlos-mkinitcpio.conf
    /etc/initcpio
    /etc/udev/rules.d/81-dhcpcd.rules
    /root/{.automated_script.sh,.zlogin}
  )
  local i
  for i in ${files_rm[*]}; do rm -rf $i; done
  find /usr/lib/initcpio -name archiso* -type f -exec rm '{}' \;
}

fix_conf() {
    sed -i 's/#\(HandleSuspendKey=\)ignore/\1suspend/' /etc/systemd/logind.conf.d/do-not-suspend.conf
    sed -i 's/#\(HandleHibernateKey=\)ignore/\1hibernate/' /etc/systemd/logind.conf.d/do-not-suspend.conf
    sed -i 's/#\(HandleLidSwitch=\)ignore/\1suspend/' /etc/systemd/logind.conf.d/do-not-suspend.conf

    sed -i 's/#\(Storage=\)volatile/\1auto/' /etc/systemd/journald.conf.d/volatile-storage.conf
}

clean_iso
fix_conf

# for i in `ls /home/`; do rm -rf /home/$i/.config/* || exit 0; done
# pacman -Rs exo --noconfirm
rm /usr/bin/cleaner.sh
