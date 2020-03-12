# Ctlos Linux iso

Home: https://ctlos.github.io

[![GitHub All Releases](https://img.shields.io/github/downloads/ctlos/ctlosiso/total.svg)](https://ctlos.github.io/get)

## Создание(build) iso

Первым параметром указываем de/wm, вторым версию(любую), иначе не отработает.

В скрипте `autobuild.sh` измените переменную `USER`, на ваше имя пользователя `st`.

    git clone https://github.com/ctlos/ctlosiso
    cd ctlosiso
    sudo ./autobuild.sh xfce 1.7.0

- Основные пакеты: packages.x86_64
- Пакеты относяшиеся к xfce: packages.xfce
