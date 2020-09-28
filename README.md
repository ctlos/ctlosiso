# Ctlos Linux iso

Home: https://ctlos.github.io

[![GitHub All Releases](https://img.shields.io/github/downloads/ctlos/ctlosiso/total.svg)](https://ctlos.github.io/get)

## Создание(build) iso

- [Подробная статья в Ctlos Wiki](https://ctlos.github.io/wiki/other/ctlosiso/)
- [Wiki Arch Linux](https://wiki.archlinux.org/index.php/archiso)
- [Archiso Repo](https://gitlab.archlinux.org/archlinux/archiso)

Установить пакеты для сборки.

```bash
yay -S git archiso mkinitcpio-archiso --noconfirm --needed
```

Измените список пакетов.

- Основные пакеты: `packages.x86_64`

В `pacman.conf` указан репозиторий [Ctlos repo](https://github.com/ctlos/ctlos_repo/tree/dev), соответственно пакеты беруться и отсюда `x86_64`.

- Конфиги системы в `/airootfs` это будущий корень.
- Конфиги пользователя в `/airootfs/etc/skel`.
- Часть конфигов залетает в систему, через пакеты ctlos, например [ctlos-bspwm-skel](https://github.com/ctlos/ctlos-bspwm-skel)
- Основной скрипт генерации `/airootfs/root/customize_airootfs.sh`.
- Готовый образ и хэши создаются в данной директории `/out`.
- Скрипт `mkarchiso` это немного измененный стандартный скрипт из `archiso`, добавлено выполнение скрипта `chroot.sh` перед сжатием `mksquashfs`.
- Скрипт `autobuild.sh` дополнительная обертка над `mkarchiso`.

Можно клонировать определенную ветку, с нужным de/wm (xfce/bspwm).

```sh
git clone -b bspwm git@github.com:ctlos/ctlosiso.git
```

Или мастер(master) по умолчанию.

```sh
git clone https://github.com/ctlos/ctlosiso
cd ctlosiso
chmod +x {autobuild.sh,chroot.sh,mkarchiso}

# Передаем аргумент de/wm_версия, можно любой, иначе не отработает.

sudo ./autobuild.sh bspwm_1.7.0
```

Получить удаленную ветку и переключиться на неё.

```sh
git checkout -b openbox origin/openbox
```
