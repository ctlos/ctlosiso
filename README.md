# Ctlos Linux iso

Home: https://ctlos.github.io

[![GitHub All Releases](https://img.shields.io/github/downloads/ctlos/ctlosiso/total.svg)](https://ctlos.github.io/get)

## Создание(build) iso

[Подробная статья в wiki](https://ctlos.github.io/wiki/other/ctlosiso/).

Установить пакеты для сборки.

```bash
yay -S git arch-install-scripts archiso --noconfirm
```

Первым параметром указываем de/wm, ориентир файл packages.openbox(de/wm). Вторым версию(любую), иначе не отработает.

В скрипте `autobuild.sh` измените переменную `USER`, на ваше имя пользователя `st`, или оставьте `$(whoami)`.

Измените список пакетов.

- Основные пакеты: packages.x86_64
- Пакеты относяшиеся к openbox: packages.openbox

В `pacman.conf` указан репозиторий [Ctlos repo](https://github.com/ctlos/ctlos_repo), соответственно пакеты беруться и отсюда `x86_64`.

- Конфиги системы в `/airootfs` это будущий корень.
- Конфиги пользователя в `/airootfs/etc/skel`.
- Часть конфигов залетает в систему, через пакеты ctlos, например [ctlos-openbox-skel](https://github.com/ctlos/ctlos-openbox-skel)
- Основной скрипт генерации `/airootfs/root/customize_airootfs.sh`.
- Готовый образ и хэши создаются в данной директории `/out`.

```sh
git clone https://github.com/ctlos/ctlosiso
cd ctlosiso
chmod +x {autobuild.sh,build.sh,chroot.sh,mkarchiso}
sudo ./autobuild.sh openbox 1.7.0
```

Можно клонировать определенную ветку, с нужным de/wm (xfce/bspwm).

```sh
git clone -b xfce git@github.com:ctlos/ctlosiso.git
```

Получить удаленную ветку и переключиться на неё.

```sh
git checkout -b bspwm origin/bspwm
```
