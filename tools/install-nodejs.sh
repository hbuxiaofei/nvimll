#!/bin/bash

cd $(dirname $0)

INSTALL_HOME=$HOME
[ -n "$SUDO_USER" ] && INSTALL_HOME=/home/$SUDO_USER

# check
if [ -e "$HOME/.config/nodejs/bin/node" ]; then
    echo -e "\033[32m- [Warn] nodejs has been exist\033[0m"
    exit 0
fi

if [ ! -d "$HOME/.config/nodejs" ]; then
    mkdir -p "$HOME/.config/nodejs"
fi

nodejs_version="v22.16.0"
if [ ! -e "node-${nodejs_version}-linux-x64.tar.xz" ]; then
    wget https://nodejs.org/dist/${nodejs_version}/node-${nodejs_version}-linux-x64.tar.xz
fi
if [ $? -ne 0 ] || [ ! -e "node-${nodejs_version}-linux-x64.tar.xz" ]; then
    echo -e "\033[33m- [Err] download node-xxx.tar.xz error\033[0m"
    exit 1
fi

tar -xf node-${nodejs_version}-linux-x64.tar.xz --strip-components 1 -C $HOME/.config/nodejs/
if [ $? -ne 0 ]; then
    echo -e "\033[33m- [Err] node-xxx.tar.xz decompression failed\033[0m"
    rm -rf $HOME/.config/nodejs
    rm -f node-*.tar.xz
    exit 1
fi

echo -e "\033[32m- [Info] Install nodejs successfully...\033[0m"

exit 0
