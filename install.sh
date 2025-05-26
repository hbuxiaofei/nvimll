#!/bin/bash

USRLOCAL_BIN=/usr/local/bin
export PATH=$USRLOCAL_BIN:$PATH

INSTALL_HOME=$HOME
[ -n "$SUDO_USER" ] && INSTALL_HOME=/home/$SUDO_USER

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
    tar -xf ./tools/${filetarball} \
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
if [ -d $INSTALL_HOME/.local/share/nvim/site/autoload ]; then
	rm -rf $INSTALL_HOME/.local/share/nvim/site/autoload
fi

if [ -d $INSTALL_HOME/.config/nvim ]; then
	rm -rf $INSTALL_HOME/.config/nvim
fi


# copy files
echo -e "\033[32m- [Info] Start to copy files\033[0m"

if [ ! -d $INSTALL_HOME/.local/share/nvim/site ]; then
	mkdir -p $INSTALL_HOME/.local/share/nvim/site
fi
cp -rf autoload $INSTALL_HOME/.local/share/nvim/site/

if [ ! -d $INSTALL_HOME/.config ]; then
	mkdir -p $INSTALL_HOME/.config
fi
cp -rf nvim $INSTALL_HOME/.config/


# install command
install_ripgrep

install_pynvim() {
    if command -v apt >/dev/null 2>&1; then
        run_cmd="apt install python3-pynvim -y"
        $run_cmd
        if [ $? -ne 0 ]; then
            echo -e "\033[33m- [Err] $run_cmd error\033[0m"
            exit 1
        else
            return 0
        fi
    fi

    if command -v pip3 >/dev/null 2>&1; then
        run_cmd="pip3 install pynvim"
        $run_cmd
        if [ $? -ne 0 ]; then
            echo -e "\033[33m- [Err] $run_cmd error\033[0m"
            exit 1
        else
            return 0
        fi
    fi
}

# install requirements
echo -e "\033[32m- [Info] Start to install requirements\033[0m"

python3 -c "import pynvim" >/dev/null 2>&1
[ $? -ne 0 ] && install_pynvim

echo -e "\033[32m- [Info] Install successfully\033[0m"

if [ ! -d $INSTALL_HOME/.config/coc/extensions/node_modules/coc-rust-analyzer ]; then
    echo -e "\033[33m- [Info] Please open nvim and run :CocInstall coc-rust-analyzer \033[0m"
fi

exit 0
