" replace table with space
" No key mapped, usage :call LLvimReplaceTab()
function! LLvimReplaceTab()
  if !&binary && &filetype != 'diff'
    :%ret! 4
  endif
endfunction


" To force clearing the undo information
" From MANUAL of undo
function! LLvimWriteWithCleareUndo()
  let s:old_undolevels = &undolevels
  set undolevels=-1
  exe "normal a \<BS>\<Esc>"
  let &undolevels = s:old_undolevels
  unlet s:old_undolevels
  exe "w"
endfunction
com! -bar WW cal LLvimWriteWithCleareUndo()


function! s:LQlistGetBuffers()
  redir =>bufs
  silent! ls!
  redir END
  return bufs
endfunction
" Toggles the quickfix and location list.
" ref https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! LLvimLQlistToggle(bufname, pfx)
  let bufs = s:LQlistGetBuffers()
  for bufnum in map(filter(split(bufs, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open 5')
  if winnr() != winnr
    wincmd p
  endif
endfunction


" remove unwanted whitespace
" https://github.com/spf13/spf13-vim.git
function! LLvimStripTrailingWhitespace()
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


let s:nerdtree_buffer_number = 0
function! LLvimNERDTreeToggle()
  if g:NERDTree.IsOpen()
    exec "NERDTreeToggle"
    let s:nerdtree_buffer_number = buffer_number()
  else
    exec "NERDTreeFind"
    let s:nerdtree_buffer_number = 0
  endif
endfunction


function! LLvimAirlineCloseBuffer()
  let l:current = bufnr('%')

  if &filetype ==# 'nerdtree' || (exists('t:NERDTreeBufName') && bufname('%') == t:NERDTreeBufName)
    return
  endif

  let l:alternate = bufnr('#')
  if buflisted(l:alternate)
    buffer #
  else
    bnext
  endif
  execute 'silent! bdelete ' . l:current

  if exists('g:airline_buflist_cache')
    unlet g:airline_buflist_cache
  endif
  if exists(':AirlineRefresh')
    execute 'AirlineRefresh'
  endif

  redraw!
endfunction


function! LLvimAirlineCloseOtherBuffers()
  let l:buffer_cur_number = bufnr('%')
  let l:nt_bufnr = -1
  if exists('t:NERDTreeBufName')
    let l:nt_bufnr = bufnr(t:NERDTreeBufName)
  endif

  for l:buf in getbufinfo()
    let l:bufnr = l:buf.bufnr
    if l:bufnr == l:buffer_cur_number
      continue
    endif

    if l:bufnr == l:nt_bufnr
      continue
    endif

    if l:buf.loaded || l:buf.listed
      silent! execute 'bdelete! ' . l:bufnr
    endif
  endfor

  if exists('g:airline_buflist_cache')
    unlet g:airline_buflist_cache
  endif

  if exists(':AirlineRefresh')
    execute 'AirlineRefresh'
  endif

  redraw!
endfunction
