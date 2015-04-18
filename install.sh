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

if [ "$1" == "deploy" ]; then
    for i in _*
    do
        link_file $i
    done
fi

if [ "$1" == "undeploy" ]; then
    for i in _*
    do
        unlink_file $i
    done
fi
