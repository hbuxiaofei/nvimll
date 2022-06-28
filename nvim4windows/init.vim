set number         " 打开行号设置
set ruler          " 光标信息
set hlsearch       " 高亮显示搜索
set incsearch      " 边搜索边高亮
set ignorecase     " 忽悠大小写
set smartcase      " 有大写字母的搜索词,大小写敏感
set nocompatible   " 不与vi兼容,采用vim自己的操作命令
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

set nobackup       " 取消备份
set noswapfile     " 不创建交换文件
" set mouse=nv       " 启用鼠标
set colorcolumn=80
set scrolloff=5
set sidescrolloff=15


set t_Co=256
set termguicolors   " 开启24bit的颜色，开启这个颜色会更漂亮一些


call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'preservim/tagbar'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'flazz/vim-colorschemes'
Plug 'voldikss/vim-floaterm', { 'do': ':UpdateRemotePlugins' }
Plug 'kien/ctrlp.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'hbuxiaofei/cscope_maps'
Plug 'romainl/vim-qf'
Plug 'lfv89/vim-interestingwords'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'dense-analysis/ale'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
call plug#end()


" vim-colorschemes
colorscheme molokai " 设置主题

" nerdtree
let g:NERDTreeWinPos = "right"
let NERDTreeWinSize=25
map <F7> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree " Automatically open a NERDTree if no files

" nerdcommenter
let g:NERDSpaceDelims = 1

" ctrlp
let g:ctrlp_map = '<c-p>'

" floaterm
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
nnoremap <silent> <F9> :FloatermToggle<CR>
tnoremap <silent> <F9> <C-\><C-n>:FloatermToggle<CR>

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab
nmap <Leader>+ :bd<cr>
nmap <silent> <F3> :cp<cr>
nmap <silent> <F4> :cn<cr>

" tagbar
let g:tagbar_left=1
let g:tagbar_width=25
let g:tagbar_sort = 0
let g:tagbar_compact = 1
nmap <F5> :TagbarToggle<CR>

" vim-cpp-enhanced-highlight
let g:cpp_posix_standard = 1

" vim-qf(quickfix)
nmap <F6> <Plug>(qf_qf_toggle)

" interestingwords
let g:interestingWordsGUIColors = ['#00FF00','#FFFF00','#FF0000','#A020F0','#0000FF','#00FF7F','#BDB76B','#FFC1C1','#EE1289','#C0FF3E']

if ((filereadable("Kconfig"))&&(filereadable("Kbuild")))
    au! BufRead *.c,*.cpp |
        set tabstop=8 |
        set softtabstop=8 |
        set shiftwidth=8 |
        set noexpandtab
endif

" vim-signify
let g:signify_sign_delete = '-'

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" Showing the cscope results in a quick-fix list
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

" When editing a file, always jump to the last cursor position
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Remove unwanted whitespace
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

" ale
" rust-analyzer binary is required by ale
" https://github.com/rust-analyzer/rust-analyzer
let g:ale_linters = {'rust': ['analyzer']}
let g:ale_completion_enabled = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
function! AleRustSetting()
    nnoremap <C-]> :ALEGoToDefinition<CR>
    set completeopt=menu,menuone,noselect,noinsert
endfunction
autocmd FileType rust call AleRustSetting()
