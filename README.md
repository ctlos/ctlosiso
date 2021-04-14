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

> Для сборки необходимо подключить локально [ctlos_repo](https://ctlos.github.io/wiki/install/ctlos-repo/), или изменить под себя pacman.conf и пакеты.

Логика установщика дополнена скриптами [ctlos-sh](https://github.com/ctlos/ctlos-sh) shellprocess. [Исходники calamares](https://github.com/ctlos/calamares), смотрите ветки.

- Archiso version: 52-1

Измените список пакетов.

- Пакеты: `packages.x86_64`

В `pacman.conf` указан репозиторий [Ctlos repo](https://github.com/ctlos/ctlos_repo/tree/master), соответственно пакеты берутся и отсюда `x86_64`.

- Конфиги системы в `/airootfs` это будущий корень.
- Конфиги пользователя в `/airootfs/etc/skel`.
- Часть конфигов залетает в систему, через пакеты ctlos, [skel](https://github.com/ctlos/skel)
- Готовый образ и хэши создаются в данной директории `/out`.
- Скрипт `mkarchiso.sh` это немного измененный стандартный скрипт из `archiso`, добавлено выполнение скрипта `chroot.sh` перед сжатием `mksquashfs`.
- Скрипт `/airootfs/usr/local/bin/cleaner.sh` выполняется во время установки в установщике [calamares](https://github.com/ctlos/calamares/blob/dev/src/modules/shellprocess/shellprocess.conf), удаление некоторых файлов и каталогов.
- Скрипт `autobuild.sh` дополнительная обертка над `mkarchiso`.

Мастер(master) ветка по умолчанию, в ней xfce.

```sh
git clone --depth=1 https://github.com/ctlos/ctlosiso
cd ctlosiso

# делаем скрипты исполняемыми
chmod +x {autobuild.sh,chroot.sh,mkarchiso.sh}

# Передаем аргумент de/wm_версия, можно любой, иначе не отработает.
sudo ./autobuild.sh xfce_1.10.0
```

Получить удаленную ветку и переключиться на неё(не обязательно). Список веток меняется и не факт, что в них рабочий код. В `master` на момент коммита код рабочий.

```bash
git checkout -b dev origin/dev
```

Отладочная информация.

```bash
# Ошибки запуска сервисов
sudo systemctl --all --failed
# log X ~/
cat ~/.local/share/xorg/Xorg.1.log|grep EE
# log X (или тут)
cat /var/log/Xorg.0.log|grep EE
# Ошибки текущей загрузки
sudo journalctl -xb -0 -p 3
```
