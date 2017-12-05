" Make Backspace key work like most other apps
set backspace=indent,eol,start

" Cut, Copy, Paste
vnoremap <S-Del>	"+x
vnoremap <C-Insert>	"+y

nmap <S-Insert>	"+gP
imap <S-Insert>	<C-R><C-O>+
vmap <S-Insert>	"-d"+gP
cmap <S-Insert>	<C-R><C-O>+

" Home key alternates between start of text and column zero
function! ExtendedHome()
  let column = col('.')
  normal! ^
  if column == col('.')
    normal! 0
  endif
endfunction

noremap <silent> <Home>	:call ExtendedHome()<CR>
inoremap <silent> <Home> <C-O>:call ExtendedHome()<CR>

