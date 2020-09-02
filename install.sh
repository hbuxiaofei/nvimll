#!/bin/bash

cd $(dirname $0)

if [ -d $HOME/.local/share/nvim/site/autoload ]; then
	rm -rf $HOME/.local/share/nvim/site/autoload
fi

if [ -d $HOME/.config/nvim ]; then
	rm -rf $HOME/.config/nvim
fi

if [ ! -d $HOME/.local/share/nvim/site ]; then
	mkdir -p $HOME/.local/share/nvim/site
fi
cp -rf autoload $HOME/.local/share/nvim/site/

if [ ! -d $HOME/.config ]; then
	mkdir -p $HOME/.config
fi
cp -rf nvim $HOME/.config/

echo -e "\033[32m- Install successfully...\033[0m"

exit 0
