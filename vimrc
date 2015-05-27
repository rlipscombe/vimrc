" This comes first.
set nocompatible

" I use pathogen for managing plugins.
execute pathogen#infect()

if has("unix")
  " 'Darwin' or 'Linux'.
  let s:uname = system("echo -n \"$(uname -s)\"")
  let $PLATFORM = tolower(s:uname)
else
  let s:uname = ""
end

" Set the font, colour scheme, etc. appropriately.
if has("gui_running")
  colors desert
  if has("gui_gtk2")
    set guifont=Monospace\ 9
  elseif has("gui_win32")
    set guifont=Consolas:h10:cANSI
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h11
  endif
endif

" On Mac OS X, "set lines" causes the terminal window to be resized; we don't want that.
if has("gui_running")
  " gui_running => not in a terminal => safe to resize.
  if &lines != 50
    set lines=50
  endif
  if &columns != 120
    set columns=120
  endif
endif

" In terminal mode, use a different coloured cursor for insert mode:
if s:uname != "Darwin" && &term =~ "xterm-256color" && !has("gui_running")
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

" Delete buffer or quit if last
function ExtendedClose()
  let bufcount = len(filter(range(1, bufnr('$')), 'buflisted(v:val)==1'))
  if bufcount > 1
    exe ":bdelete"
  else
    exe ":q"
  endif
endfunction

function WriteAndClose()
    exe ":write"
    exe ":bdelete"
endfunction

nnoremap <Leader>q :call ExtendedClose()<CR>
nnoremap <Leader>w :call WriteAndClose()<CR>

" Reformat paragraph
map <Leader>p gqip

" Save all
nmap <Leader>s :wa<CR>
nmap <C-S> :w<CR>
nmap <C-S-S> :wa<CR>

" Home key alternates between start of text and column zero.
function ExtendedHome()
  let column = col('.')
  normal! ^
  if column == col('.')
    normal! 0
  endif
endfunction

noremap <silent> <Home> :call ExtendedHome()<CR>
inoremap <silent> <Home> <C-O>:call ExtendedHome()<CR>

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

" filetype stuff
filetype plugin on
filetype plugin indent on
syntax on

" Set spaces-for-tabs, 4 spaces.
set expandtab
set shiftwidth=4
set softtabstop=4

" Add some other file extensions:
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.config set ft=xml
autocmd BufNewFile,BufRead *.xaml set ft=xml
autocmd BufNewFile,BufRead *.DotSettings set ft=xml

autocmd BufNewFile,BufRead *.ejs set ft=html

autocmd BufNewFile,BufRead *.ps1,*.psm1 set shiftwidth=4 softtabstop=4

autocmd BufNewFile,BufRead *.md set ft=markdown et sts=4 sw=4 suffixesadd=.md
autocmd BufNewFile,BufRead SCons* set ft=scons
autocmd BufNewFile,BufRead *.nut set ft=squirrel

autocmd BufNewFile,BufRead *bash* let b:is_bash=1
autocmd BufNewFile,BufRead *bash* set filetype=sh syntax=sh

" For 'make', tabs = tabs.
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
autocmd BufNewFile,BufEnter Makefile set noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
autocmd BufNewFile,BufEnter *.mk set noexpandtab shiftwidth=8 softtabstop=8 tabstop=8

" Erlang
autocmd FileType erlang set expandtab shiftwidth=4 softtabstop=4 tabstop=8
autocmd BufNewFile,BufRead rebar.config set filetype=erlang
autocmd BufNewFile,BufRead *.app.src set filetype=erlang

" Django Templates (also erlydtl)
autocmd BufNewFile,BufRead *.dtl set filetype=htmldjango

" Special-case for my SSH config files:
au BufRead,BufEnter ~/.ssh/config.d/* set ft=sshconfig

function! StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

autocmd FileType c,cpp,erlang,python,ruby autocmd BufWritePre <buffer> :call StripTrailingWhitespace()

" Using syntastic; disable vimerl's syntax checker:
let g:erlang_show_errors = 0

" For erlang (not escript) files, tell syntastic to use syntaxerl (which has
" to be in $PATH to work).
au BufEnter *.erl let b:syntastic_checkers=['syntaxerl']

" Custom syntastic settings:
function s:find_jshintrc(dir)
    let l:found = globpath(a:dir, '.jshintrc')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_jshintrc(l:parent)
    endif

    return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_jshintrc(l:dir)
    let g:syntastic_javascript_jshint_conf = l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_debug = 0

" vim-makeshift:
nnoremap <C-S-B> :MakeshiftBuild<CR>

" Rainbow brackets
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" CtrlP
let g:ctrlp_custom_ignore = {
            \ 'file': '\v\.beam$',
            \ 'dir': '\v\_site$'
            \ }

" Show line numbers.
set nu
highlight LineNr guifg=#70C0F0
highlight LineNr ctermfg=gray

" ctags
set tags=tags;/

" vim: set ft=vim :
