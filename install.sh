#!/usr/bin/env bash

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -L "${target}" ]; then
        unlink $target
    fi

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

function unlink_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.bak $target
    fi
}

function link_dir {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    ln -sf ${source}/* ${target}
}

function deploy {
    for i in _*; do
        if [ -d "$i" ]; then
            link_dir "$i"
        else
            link_file "$i"
        fi
    done
}

function undeploy {
    for i in _*; do
        unlink_file "$i"
    done
}

if [ "$1" == "deploy" ]; then
    deploy
fi

if [ "$1" == "undeploy" ]; then
    undeploy
fi
