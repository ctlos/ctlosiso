Home: https://ctlos.github.io

[![GitHub All Releases](https://img.shields.io/github/downloads/ctlos/ctlosiso/total.svg)](https://ctlos.github.io/get)

## Создание(build) iso

[Подробная статья в wiki](https://ctlos.github.io/wiki/other/ctlosiso/).

Установить пакеты для сборки.

```bash
sudo pacman -S git arch-install-scripts
yay -S archiso
```

Можно клонировать определенную ветку, с нужным de/wm (xfce/budgie/bspwm/i3).

```sh
git clone -b xfce git@github.com:ctlos/ctlosiso.git
```

Первым параметром указываем de/wm, вторым версию(любую), иначе не отработает.

В скрипте `autobuild.sh` измените переменную `USER`, на ваше имя пользователя `st`.

```sh
git clone https://github.com/ctlos/ctlosiso
cd ctlosiso
sudo ./autobuild.sh openbox 1.7.0
```

Измените список пакетов.

- Основные пакеты: packages.x86_64
- Пакеты относяшиеся к openbox: packages.openbox

В `pacman.conf` указан репозиторий [Ctlos repo](https://github.com/ctlos/ctlos_repo), соответственно пакеты беруться и отсюда `x86_64`.

- Конфиги системы в `/airootfs` это будущий корень.
- Конфиги пользователя в `/airootfs/etc/skel`.
- Часть конфигов залетает в систему, через пакеты ctlos, например [openbox-config](https://github.com/ctlos/openbox-config)
- Основной скрипт генерации `/airootfs/root/customize_airootfs.sh`.
- Готовый образ и хэши создаются в данной директории `/out`.
