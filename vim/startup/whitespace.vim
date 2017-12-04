" Trim trailing whitespace when saving certain file types
function! StripTrailingWhitespace()
  let pos = getpos('.')

  %s/\s\+$//e

  call setpos('.', pos)  
endfunction

autocmd FileType c,cpp,erlang,markdown,python,ruby autocmd BufWritePre <buffer> :call StripTrailingWhitespace()
