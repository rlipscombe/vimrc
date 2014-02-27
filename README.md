# Installation

## On Unix-like things

    cd ~
    git clone --recursive git://github.com/rlipscombe/vimrc.git vimrc
    vimrc/mk

## On Windows, using Command Prompt

    cd %HOME%
    git clone --recursive git://github.com/rlipscombe/vimrc.git vimrc
    
The next bit has to be done from an **elevated Command Prompt**:

    cd %HOME%
    mklink _vimrc vimrc\vimrc
    mklink /D vimfiles vimrc\vim
