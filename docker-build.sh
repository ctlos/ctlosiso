#!/usr/bin/env bash
set -e

if ! type docker >/dev/null 2>&1; then
    echo "You have to install docker in your system before." 1>&2
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    cat - 1>&2 <<LOL
Cannot connect to docker socket.
LOL
    exit 1
fi

script_path=$(realpath -- ${0%/*})

tty >/dev/null 2>&1 && OPT_TTY="-it" || OPT_TTY=""

DOCKER_RUN_OPTS=()
# DOCKER_RUN_OPTS+=(-v "${script_path}/out:/ctlos/out")
# DOCKER_RUN_OPTS+=(-v "${script_path}/work:/ctlos/work")

if [[ -d "${script_path}/out" ]]; then
    mkdir -p "${script_path}/out"
else
    rm -rf "${script_path}/out"
fi
DOCKER_RUN_OPTS+=(-v "${script_path}/out:/ctlos/out")

if [[ -d "${script_path}/work" ]]; then
    mkdir -p "${script_path}/work"
else
    rm -rf "${script_path}/work"
fi
DOCKER_RUN_OPTS+=(-v "${script_path}/work:/ctlos/work")

docker build --no-cache -t ctlos-build:latest "${script_path}"
exec docker run --rm ${OPT_TTY} --privileged -e _DOCKER=true "${DOCKER_RUN_OPTS[@]}" ctlos-build "${1}"