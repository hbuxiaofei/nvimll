let g:deoplete#enable_at_startup = 1

call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'racer-rust/vim-racer', { 'do': ':UpdateRemotePlugins' }

call plug#end()

