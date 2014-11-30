# Installation

## On Unix-like things

    cd ~
    git clone --recursive git://github.com/rlipscombe/vimrc.git vimrc
    vimrc/mk

## On Windows, using Command Prompt

    cd /d %HOMEDRIVE%%HOMEPATH%
    git clone --recursive git://github.com/rlipscombe/vimrc.git vimrc
    
The next bit has to be done from an **elevated Command Prompt**:

    cd /d %HOMEDRIVE%%HOMEPATH%
    mklink _vimrc vimrc\vimrc
    mklink /D vimfiles vimrc\vim

# Plugins

Using [Pathogen](https://github.com/tpope/vim-pathogen), and git submodules:

    cd /path/to/vimrc
    git submodule add git://github.com/tpope/vim-liquid vim/bundle/vim-liquid

(for example)
