" Cut, Copy, Paste
noremap <S-Del> "+x
noremap <C-Insert> "+y

noremap <Leader>y "+y
noremap <Leader>x "+x

nmap <S-Insert>	"+gP
imap <S-Insert>	<C-R><C-O>+
vmap <S-Insert>	"-d"+gP
cmap <S-Insert>	<C-R><C-O>+
