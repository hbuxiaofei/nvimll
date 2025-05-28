call plug#begin('~/.config/nvim/plugged')

Plug 'll/ll.vim', { 'do': ':UpdateRemotePlugins' }

Plug 'sickill/vim-monokai', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdtree', { 'do': ':UpdateRemotePlugins' }

" 高亮显示多个不同的单词, 使用 <Leader>k 高亮光标下的单词
Plug 'lfv89/vim-interestingwords', { 'do': ':UpdateRemotePlugins' }

" Plug 'jiangmiao/auto-pairs', { 'do': ':UpdateRemotePlugins' }
Plug 'kien/ctrlp.vim', { 'do': ':UpdateRemotePlugins' }

" 快速注释代码
Plug 'preservim/nerdcommenter', { 'do': ':UpdateRemotePlugins' }

Plug 'MattesGroeger/vim-bookmarks', { 'do': ':UpdateRemotePlugins' }
Plug 'voldikss/vim-floaterm', { 'do': ':UpdateRemotePlugins' }

Plug 'Yggdroot/LeaderF', { 'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/LeaderF-marks', { 'do': ':UpdateRemotePlugins' }

" <C-n> 选择多个修改, <C-x> 跳过当前匹配
Plug 'terryma/vim-multiple-cursors', { 'do': ':UpdateRemotePlugins' }

" 所有 Git 命令都可以通过 :Git 命令或其简写 :G 来调用
Plug 'tpope/vim-fugitive', { 'do': ':UpdateRemotePlugins' }

Plug 'octol/vim-cpp-enhanced-highlight', { 'do': ':UpdateRemotePlugins' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets', { 'do': ':UpdateRemotePlugins' }

Plug 'rust-lang/rust.vim', { 'do': ':UpdateRemotePlugins' }

call plug#end()


set number

" disable mouse
set mouse=

" enable syntax
syntax enable
syntax on

" highlight current line
set cursorline

" colorscheme peachpuff
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
set scrolloff=5
set sidescrolloff=15
set laststatus=2

set encoding=utf-8
set fileencoding=utf-8

" 将leader:'\' 设置为空格键
let mapleader = " "

" remove unwanted whitespace
autocmd BufWritePre * call LLvimStripTrailingWhitespace()
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab
nmap <silent> <leader>+ :call LLvimAirlineBufferClose()<CR>


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
nmap <silent> <F7> :call LLvimNERDTreeToggle()<CR>


" ctrlp
let g:ctrlp_working_path_mode = 'wa'
let g:ctrlp_match_window = 'min:1,max:15,results:100'

" leaderf
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Rg':1 , 'Line': 1, 'Colorscheme': 1}
let g:Lf_PopupPreviewPosition = 'bottom'
let g:Lf_ShortcutF = "<leader>ff"
noremap <Leader>fa :<C-U><C-R>=printf("Leaderf rg -e \"%s\"", expand("<cword>"))<CR>
noremap <Leader>fr :<C-U><C-R>=printf("Leaderf rg --all-buffers -e \"%s\"", expand("<cword>"))<CR>
noremap <leader>fl :<C-U><C-R>=printf("LeaderfLine")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("LeaderfMarks")<CR><CR>

" vim-bookmarks
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_show_toggle_warning = 0
let g:bookmark_save_per_working_dir = 1
nmap <Leader>mm <Plug>BookmarkToggle
nmap <Leader>mi <Plug>BookmarkAnnotate
nmap <Leader>ma <Plug>BookmarkShowAll
nmap <Leader>mx <Plug>BookmarkClearAll

" nerdcommenter
let g:NERDSpaceDelims = 1


" floaterm
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
nnoremap <silent> <F9> :FloatermToggle<CR>
tnoremap <silent> <F9> <C-\><C-n>:FloatermToggle<CR>

" vim-multiple-cursors
func! Multiple_cursors_before()
  if exists('g:AutoPairsLoaded')
    call AutoPairsToggle()
  end
endfunc
func! Multiple_cursors_after()
  if exists('g:AutoPairsLoaded')
    call AutoPairsToggle()
  end
endfunc


" quickfix
nmap <silent> <leader><F6> :call LLvimLQlistToggle("Location List", 'l')<CR>
nmap <silent> <F6> :call LLvimLQlistToggle("Quickfix List", 'c')<CR>
nmap <silent> <F3> :cp<cr>
nmap <silent> <F4> :cn<cr>

" coc.nvim
" all coc extensions: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
"
" wget https://nodejs.org/dist/v22.16.0/node-v22.16.0-linux-x64.tar.xz
" tar -xf node-v22.16.0-linux-x64.tar.xz --strip-components 1 -C /usr/
" xmap <leader>fm  <Plug>(coc-format-selected)
" nmap <leader>fm  <Plug>(coc-format-selected)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
set pumheight=10


" coc.nvim rust
" wget https://github.com/rust-lang/rust-analyzer/releases/download/2024-01-29/rust-analyzer-x86_64-unknown-linux-gnu.gz
" nvim -> :CocInstall coc-rust-analyzer

" coc.nvim c++
" wget https://github.com/clangd/clangd/releases/download/18.1.3/clangd-linux-18.1.3.zip
" nvim -> :CocInstall coc-clangd
