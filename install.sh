#!/bin/bash


cd $(dirname $0)


# https://github.com/BurntSushi/ripgrep
install_ripgrep()
{
    local version="12.1.1"
    local filename="ripgrep-${version}-x86_64-unknown-linux-musl"
    local filetarball="ripgrep-${version}-x86_64-unknown-linux-musl.tar.gz"
    local exename="rg"
    local bindir=""

    if command -v rg >/dev/null 2>&1; then
        return 0
    fi

    [ -d /bin ] && bindir="/bin"
    [ -d /usr/bin ] && bindir="/usr/bin"
    [ -d /usr/local/bin ] && bindir="/usr/local/bin"

    if [ -z "$bindir" ]; then
        echo -e "\033[33m- [Warn] install ripgrep failed, bin directory not found\033[0m"
        return 1
    fi

    echo -e "\033[32m- [Info] Install rg to ${bindir}\033[0m"
    tar -xvf ./tools/${filetarball} \
        --strip-components 1 \
        --directory=${bindir} \
        ${filename}/${exename}

    chmod +x ${bindir}/${exename}

    if ! command -v rg >/dev/null 2>&1; then
        echo -e "\033[33m- [Warn] install ripgrep failed\033[0m"
        return 1
    fi
}

# prepare
if [ -d $HOME/.local/share/nvim/site/autoload ]; then
	rm -rf $HOME/.local/share/nvim/site/autoload
fi

if [ -d $HOME/.config/nvim ]; then
	rm -rf $HOME/.config/nvim
fi


# copy files
echo -e "\033[32m- [Info] Start to copy files\033[0m"

if [ ! -d $HOME/.local/share/nvim/site ]; then
	mkdir -p $HOME/.local/share/nvim/site
fi
cp -rf autoload $HOME/.local/share/nvim/site/

if [ ! -d $HOME/.config ]; then
	mkdir -p $HOME/.config
fi
cp -rf nvim $HOME/.config/


# install command
install_ripgrep


# install requirements
echo -e "\033[32m- [Info] Start to install requirements\033[0m"

if ! command -v pip3 >/dev/null 2>&1; then
    echo -e "\033[33m- [Err] pip3: command not found\033[0m"
    exit 1
fi

is_exist=$(pip3 list 2>/dev/null | grep ^pynvim)
if [ x"$is_exist" == x ]; then
    run_cmd="pip3 install pynvim"
    $run_cmd
    if [ $? -ne 0 ]; then
        echo -e "\033[33m- [Err] $run_cmd error\033[0m"
        exit 1
    fi
fi


echo -e "\033[32m- [Info] Install successfully...\033[0m"

exit 0
