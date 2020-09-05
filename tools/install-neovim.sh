#!/bin/bash

cd $(dirname $0)

# https://github.com/neovim/neovim/releases
neovim_name="nvim-linux64"
neovim_tarball="${neovim_name}.tar.gz"
neovim_url="https://github.com/neovim/neovim/releases/download/stable/${neovim_tarball}"

download_neovim()
{
    if ! command -v wget >/dev/null 2>&1; then
        echo -e "\033[33m- [Err] wget: command not found\033[0m"
        exit 1
    fi

    wget $neovim_url
    if [ $? -ne 0 ]; then
        echo -e "\033[33m- [Err] get stable neovim error\033[0m"
        exit 1
    fi
}

check_conflict()
{
    local tempfile=$(mktemp -t temp.XXXXXX)
    local _line=""
    local _ok="false"
    local is_conflict=0
    if [ ! -e "$neovim_tarball" ]; then
        echo -e "\033[33m- [Err] $neovim_tarball not found\033[0m"
        rm -f $tempfile
        exit 1
    fi

    tar -tf $neovim_tarball > $tempfile
    if [ $? -ne 0 ]; then
        echo -e "\033[33m- [Err] $neovim_tarball decompression failed\033[0m"
        rm -f $tempfile
        exit 1
    fi

    sed -i "s#^${neovim_name}#/usr#g" $tempfile
    sed -i '/.*\/$/d' $tempfile

    while read _line; do
        if [ -n "$_line" ] && [ -e "$_line" ] ; then
            echo -e "\033[33m- [Warn] file $_line conflict\033[0m"
            is_conflict=1
        fi

        if [ x"$_line" == x"/usr/bin/nvim" ]; then
            _ok="true"
        fi
    done  < $tempfile

    rm -f $tempfile

    if [ x"$_ok" != x"true" ]; then
        echo -e "\033[33m- [Err] $neovim_tarball seems not be complete\033[0m"
        exit 1
    fi

    return $is_conflict
}


# download
download_neovim

# check conflict
check_conflict
if [ $? -ne 0 ]; then
    echo -e "\033[33m- [Err] Install failed...\033[0m"
    exit 1
fi

# decompression
tar -xf $neovim_tarball --strip-components 1 -C /usr/ || exit 1


echo -e "\033[32m- [Info] Install successfully...\033[0m"

exit 0
