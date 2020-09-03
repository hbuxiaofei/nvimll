call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim', { 'do': ':UpdateRemotePlugins' }

Plug 'sickill/vim-monokai', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdtree', { 'do': ':UpdateRemotePlugins' }
Plug 'lfv89/vim-interestingwords', { 'do': ':UpdateRemotePlugins' }
Plug 'jiangmiao/auto-pairs', { 'do': ':UpdateRemotePlugins' }
Plug 'kien/ctrlp.vim', { 'do': ':UpdateRemotePlugins' }

Plug 'racer-rust/vim-racer', { 'do': ':UpdateRemotePlugins' }

Plug 'deoplete-plugins/deoplete-go', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'deoplete-plugins/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim', { 'do': ':UpdateRemotePlugins' }

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
" https://github.com/spf13/spf13-vim.git
function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
endfunction
autocmd BufWritePre * call StripTrailingWhitespace()
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


" rust
" need RUST_SRC_PATH environment
" export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
augroup END
