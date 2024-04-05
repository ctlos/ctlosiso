FROM archlinux:latest

RUN rm -v /etc/pacman.d/gnupg/*.gpg && sed -i '1iallow-weak-key-signatures' /etc/pacman.d/gnupg/gpg.conf && \
    pacman-key --init && pacman-key --populate && \
    pacman -Syy --noconfirm archlinux-keyring mkinitcpio systemd lvm2 mdadm cryptsetup dbus && \
    echo 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist && \
    pacman -Syy --noconfirm --needed base-devel reflector git squashfs-tools archiso mkinitcpio-archiso && \
    reflector -p "http,https" -c ",by,ru" --sort rate -f 5 --save /etc/pacman.d/mirrorlist && \
    curl -LO git.io/strap.sh && bash strap.sh

COPY . /ctlos
WORKDIR /ctlos

ENTRYPOINT ["./autobuild.sh"]
CMD []