" set nocompatible " 关闭兼容模式
" filetype off     " 关闭自动补全

set number         " 打开行号设置
set ruler          " 光标信息
set hlsearch       " 高亮显示搜索
set incsearch      " 边搜索边高亮
set ignorecase     " 忽悠大小写
" set cursorline   " 突出当前显示行

set ts=4           " tab 占4个字符宽度
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent     " 复制上一行的缩进
set encoding=utf-8

filetype plugin on
syntax enable      " 语法高亮
syntax on

set t_Co=256
colorscheme desert " 设置主题
set termguicolors  " 开启24bit的颜色，开启这个颜色会更漂亮一些

set nobackup       " 取消备份
set noswapfile
set mouse=a        " 启用鼠标
set colorcolumn=80
highlight ColorColumn guibg=Gray

call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'preservim/tagbar'
Plug 'voldikss/vim-floaterm', { 'do': ':UpdateRemotePlugins' }
Plug 'justinmk/vim-syntax-extra'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'hbuxiaofei/cscope_maps'
Plug 'romainl/vim-qf'
Plug 'lfv89/vim-interestingwords'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
call plug#end()

let g:NERDTreeWinPos = "right"
let NERDTreeWinSize=25
map <F7> :NERDTreeToggle<CR>

" Automatically open a NERDTree if no files where specified
autocmd vimenter * if !argc() | NERDTree

" nerdcommenter
let g:NERDSpaceDelims = 1

let g:ctrlp_map = '<c-p>'

nmap <F5> :TagbarToggle<CR>
let g:tagbar_left=1

" floaterm
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
nnoremap <silent> <F9> :FloatermToggle<CR>
tnoremap <silent> <F9> <C-\><C-n>:FloatermToggle<CR>

let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab
nmap <Leader>+ :bd<cr>
nmap <silent> <F3> :cp<cr>
nmap <silent> <F4> :cn<cr>


if ((filereadable("Kconfig"))&&(filereadable("Kbuild")))
    au! BufRead *.c,*.cpp |
        set tabstop=8 |
        set softtabstop=8 |
        set shiftwidth=8 |
        set noexpandtab
endif

if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
endif

function! LeeCtagsCscope()
    if $filetype == 'go'
        :silent !find . -name "*.go" >> cscope.files
    elseif &filetype == 'python'
        :silent !find . -name "*.py" >> cscope.files
    endif
    :silent !ctags -R --fields=+lS && cscope -Rbqk
endfunction
nmap <F8> :call LeeCtagsCscope()<cr>

nmap <F6> <Plug>(qf_qf_toggle)

autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

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

" interestingwords
let g:interestingWordsGUIColors = ['#00FF00','#FFFF00','#FF0000','#A020F0','#0000FF','#00FF7F','#BDB76B','#FFC1C1','#EE1289','#C0FF3E']
