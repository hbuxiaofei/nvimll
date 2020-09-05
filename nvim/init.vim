call plug#begin('~/.config/nvim/plugged')

Plug 'll/ll.vim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim', { 'do': ':UpdateRemotePlugins' }

Plug 'sickill/vim-monokai', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdtree', { 'do': ':UpdateRemotePlugins' }
Plug 'lfv89/vim-interestingwords', { 'do': ':UpdateRemotePlugins' }
Plug 'jiangmiao/auto-pairs', { 'do': ':UpdateRemotePlugins' }
Plug 'kien/ctrlp.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'rayylee/asyncrun.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdcommenter', { 'do': ':UpdateRemotePlugins' }
Plug 'voldikss/vim-floaterm', { 'do': ':UpdateRemotePlugins' }

Plug 'racer-rust/vim-racer', { 'do': ':UpdateRemotePlugins' }

Plug 'deoplete-plugins/deoplete-go', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'deoplete-plugins/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/deoplete-clangx', { 'do': ':UpdateRemotePlugins' }

call plug#end()


set number

" enable syntax
syntax enable
syntax on

colorscheme monokai

set history=1024

" search
set hlsearch
set ignorecase
set incsearch
set smartindent

set showmatch " match {}, [], () and so on
set completeopt=menu

set autoread        " read file when changed outside
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
set expandtab       " use space when <Tab>

set colorcolumn=80
set laststatus=2

set encoding=utf-8
set fileencoding=utf-8

" remove unwanted whitespace
autocmd BufWritePre * call LLvimStripTrailingWhitespace()
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" enable deoplete
let g:deoplete#enable_at_startup = 1

" disable go version warning, this will happen when nvim version is too low
let g:go_version_warning = 0

" disable jedi-vim complete
let g:jedi#completions_enabled = 0


" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab
nmap <Leader>+ :bd<cr>


" tagbar
let g:tagbar_left=1
let g:tagbar_width=30
let g:tagbar_sort = 0
let g:tagbar_compact = 1
nmap <F5> :TagbarToggle<cr>


" nerdtree
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <F7> :NERDTreeToggle<cr>


" floaterm
nnoremap <silent> <F9> :FloatermToggle<CR>
tnoremap <silent> <F9> <C-\><C-n>:FloatermToggle<CR>


" quickfix
nmap <silent> <leader><F6> :call LLvimLQlistToggle("Location List", 'l')<CR>
nmap <silent> <F6> :call LLvimLQlistToggle("Quickfix List", 'c')<CR>

" asyncrun
let g:asyncrun_open=10
autocmd BufRead,BufNewFile *.go let g:asyncrun_raw = 1

" rust
" need RUST_SRC_PATH environment
" export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
augroup END
