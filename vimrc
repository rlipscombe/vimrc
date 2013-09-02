execute pathogen#infect()

if has("gui_running")
  colors desert
  if has("gui_gtk2")
    set guifont=Monospace\ 9
  elseif has("gui_win32")
    set guifont=Consolas:h10:cANSI
  endif
endif

" On Mac, this causes the terminal window to be resized; we don't want that.
if has("gui_running")
  set lines=50
  set columns=120
endif

" Make Backspace key work like most other apps
set backspace=indent,eol,start

" Shift+Del -> Cut, Ctrl+Ins -> Copy, Shift+Ins -> Paste
vnoremap <S-Del>    "+x
vnoremap <C-Insert> "+y

map <S-Insert>      "+gP
cmap <S-Insert>     <C-R>+
imap <S-Insert>     <C-R>+
vmap <S-Insert>     <C-R>+

" Current directory follows active file
autocmd BufEnter * silent! lcd %:p:h

" Status bar shows line, col:
set laststatus=2
set statusline=Ln\ %l\ Col\ %v\ %F\ (%{&ff},\ %Y)

" Tab completion
set wildmode=longest,list,full
set wildmenu

set nocompatible
filetype plugin on
filetype plugin indent on
syntax on

" Set spaces-for-tabs, 2 spaces.
set expandtab
set shiftwidth=2
set softtabstop=2

" Keyboard selection is more like Windows
set selectmode=mouse,key
set selection=exclusive
set keymodel=startsel,stopsel

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

autocmd BufNewFile,BufRead *.md set ft=markdown
autocmd BufNewFile,BufRead SCons* set ft=scons

autocmd BufNewFile,BufRead *bash* let b:is_bash=1
autocmd BufNewFile,BufRead *bash* set filetype=sh syntax=sh

augroup EI
  au BufRead,BufEnter ~/Source/imp/* set et sts=4 sw=4
augroup END
" vim: set ft=vim :
