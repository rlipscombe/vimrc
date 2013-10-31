" This comes first.
set nocompatible

" I use pathogen for managing plugins.
execute pathogen#infect()

" Set the font, colour scheme, etc. appropriately.
if has("gui_running")
  colors desert
  if has("gui_gtk2")
    set guifont=Monospace\ 9
  elseif has("gui_win32")
    set guifont=Consolas:h10:cANSI
  endif
  " TODO: How do we detect Mac? That said, the default "menlo" font is
  " acceptable.
endif

" On Mac OS X, "set lines" causes the terminal window to be resized; we don't want that.
if has("gui_running")
  " gui_running => not in a terminal => safe to resize.
  set lines=50
  set columns=120
  " TODO: This is broken if you :so % while maximized...
endif

" In terminal mode, use a different coloured cursor for insert mode:
if &term =~ "xterm-256color"
    " Use an orange cursor in insert mode.
    let &t_SI = "\<Esc>]12;orange\x7"
    " Use a white cursor otherwise, and set it initially.
    let &t_EI = "\<Esc>]12;white\x7"
    silent !echo -ne "\E]12;white\x7"
    " Reset it when exiting.
    autocmd VimLeave * silent !echo -ne "\E]12;white\x7"
end

" Make Backspace key work like most other apps
set backspace=indent,eol,start

" In Visual and Select mode, map Shift+Del -> Cut, and Ctrl+Ins -> Copy.
" '+' is the cut buffer on X11, the clipboard on Windows.
vnoremap <S-Del>    "+x
vnoremap <C-Insert> "+y

" Shift+Ins -> Paste...
"  "+gP pastes from the clipboard
"   (n)ormal mode
nmap <S-Insert> "+gP
"   (i)nsert mode - Paste with auto-indent turned off.
"   See http://www.reddit.com/r/programming/comments/ddbuc/how_i_boosted_my_vim/c0zelsm
imap <S-Insert> <C-R><C-O>+
"   (v)isual+select mode - ???
vmap <S-Insert> "-d"+gP
"   (c)ommand-line mode - ???
cmap <S-Insert> <C-R><C-O>+

" Delete buffer
map <Leader>q :bdel<Enter>

" Reformat paragraph
map <Leader>p gqip

" Current directory follows active file
autocmd BufEnter * silent! lcd %:p:h

" Lose the toolbar:
set guioptions-=T

" Status bar shows line, col, file, file-format, file-type:
set laststatus=2
set statusline=Ln\ %l\ Col\ %v\ %F\ (%{&ff},\ %Y)

" Tab completion
set wildmode=longest,list,full
set wildmenu

filetype plugin on
filetype plugin indent on
syntax on

" Set spaces-for-tabs, 2 spaces.
set expandtab
set shiftwidth=2
set softtabstop=2

" electric imp uses tab width 4.
augroup EI
  au BufRead,BufEnter ~/Source/imp/* set et sts=4 sw=4
augroup END

" Keyboard selection is more like Windows
set selectmode=mouse,key
set selection=exclusive
set keymodel=startsel,stopsel

" Allow moving away from modified buffers
set hidden

" Indentation
set autoindent

" Visual bell
set visualbell

" Add some other file extensions:
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.config set ft=xml
autocmd BufNewFile,BufRead *.xaml set ft=xml
autocmd BufNewFile,BufRead *.DotSettings set ft=xml

autocmd BufNewFile,BufRead *.ejs set ft=html

autocmd BufNewFile,BufRead *.ps1,*.psm1 set shiftwidth=4 softtabstop=4

autocmd BufNewFile,BufRead *.md set ft=markdown et sts=4 sw=4
autocmd BufNewFile,BufRead SCons* set ft=scons
autocmd BufNewFile,BufRead *.nut set ft=squirrel

autocmd BufNewFile,BufRead *bash* let b:is_bash=1
autocmd BufNewFile,BufRead *bash* set filetype=sh syntax=sh

" For 'make', tabs = tabs.
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=8

" Erlang
autocmd FileType erlang set expandtab shiftwidth=4 softtabstop=4 tabstop=8
autocmd BufNewFile,BufRead rebar.config set filetype=erlang
autocmd BufNewFile,BufRead *.app.src set filetype=erlang

" Django Templates (also erlydtl)
autocmd BufNewFile,BufRead *.dtl set filetype=htmldjango

" Custom syntastic settings:
let g:syntastic_javascript_jshint_conf="~/.jshintrc"
let g:syntastic_always_populate_loc_list=1

" Rainbow brackets
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Show line numbers.
set nu
highlight LineNr guifg=#70C0F0
highlight LineNr ctermfg=gray

" vim: set ft=vim :
