call plug#begin('~/.config/nvim/plugged')

Plug 'll/ll.vim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim', { 'do': ':UpdateRemotePlugins' }

Plug 'sickill/vim-monokai', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdtree', { 'do': ':UpdateRemotePlugins' }
Plug 'lfv89/vim-interestingwords', { 'do': ':UpdateRemotePlugins' }
" Plug 'jiangmiao/auto-pairs', { 'do': ':UpdateRemotePlugins' }
Plug 'kien/ctrlp.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'skywind3000/asyncrun.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdcommenter', { 'do': ':UpdateRemotePlugins' }
Plug 'voldikss/vim-floaterm', { 'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/LeaderF', { 'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/LeaderF-marks', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips', { 'do': ':UpdateRemotePlugins' }
Plug 'honza/vim-snippets', { 'do': ':UpdateRemotePlugins' }
Plug 'terryma/vim-multiple-cursors', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/gv.vim', { 'do': ':UpdateRemotePlugins' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

Plug 'deoplete-plugins/deoplete-go', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'deoplete-plugins/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/deoplete-clangx', { 'do': ':UpdateRemotePlugins' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'do': ':UpdateRemotePlugins' }

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

" remove unwanted whitespace
autocmd BufWritePre * call LLvimStripTrailingWhitespace()
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" enable deoplete
let g:deoplete#enable_at_startup = 1

" disable go version warning, this will happen when nvim version is too low
let g:go_version_warning = 0

" vim-go
let g:go_list_type = "quickfix"
let g:go_list_height = 10
autocmd FileType go nmap <C-[> <Plug>(go-implements)

" jedi-vim
let g:jedi#popup_on_dot = 0



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
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Rg':1 , 'Line': 1, 'Colorscheme': 1}
let g:Lf_PopupPreviewPosition = 'bottom'
let g:Lf_ShortcutF = "<leader>ff"
noremap <Leader>fa :<C-U><C-R>=printf("Leaderf rg -e \"%s\"", expand("<cword>"))<CR>
noremap <Leader>fr :<C-U><C-R>=printf("Leaderf rg --all-buffers -e \"%s\"", expand("<cword>"))<CR>
noremap <leader>fl :<C-U><C-R>=printf("LeaderfLine")<CR><CR>


" nerdcommenter
let g:NERDSpaceDelims = 1


" floaterm
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
nnoremap <silent> <F9> :FloatermToggle<CR>
tnoremap <silent> <F9> <C-\><C-n>:FloatermToggle<CR>


" ultisnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"


" vim-multiple-cursors
func! Multiple_cursors_before()
  if exists('g:AutoPairsLoaded')
    call AutoPairsToggle()
  end
  if deoplete#is_enabled()
    call deoplete#disable()
    let g:deoplete_is_enable_before_multi_cursors = 1
  else
    let g:deoplete_is_enable_before_multi_cursors = 0
  endif
endfunc
func! Multiple_cursors_after()
  if exists('g:AutoPairsLoaded')
    call AutoPairsToggle()
  end
  if g:deoplete_is_enable_before_multi_cursors
    call deoplete#enable()
  endif
endfunc


" quickfix
nmap <silent> <leader><F6> :call LLvimLQlistToggle("Location List", 'l')<CR>
nmap <silent> <F6> :call LLvimLQlistToggle("Quickfix List", 'c')<CR>
nmap <silent> <F3> :cp<cr>
nmap <silent> <F4> :cn<cr>

" asyncrun
let g:asyncrun_open=10
autocmd BufRead,BufNewFile *.go let g:asyncrun_raw = 1

" coc.nvim
" all coc extensions: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
"
" weget https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz
" tar -xf node-v20.11.0-linux-x64.tar.xz --strip-components 1 -C /usr/
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc.nvim rust
" wget https://github.com/rust-lang/rust-analyzer/releases/download/2024-01-29/rust-analyzer-x86_64-unknown-linux-gnu.gz
" nvim -> :CocInstall coc-rust-analyzer

" coc.nvim c++
" wget https://github.com/clangd/clangd/releases/download/18.1.3/clangd-linux-18.1.3.zip
" nvim -> :CocInstall coc-clangd

" deoplete-tabnine
" https://areweideyet.com
" https://www.tabnine.com
" https://github.com/codota/TabNine
call deoplete#custom#var('tabnine', {'line_limit': 100, 'max_num_results': 5})
