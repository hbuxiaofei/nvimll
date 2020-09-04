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
