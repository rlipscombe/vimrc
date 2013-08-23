#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for i in vimrc vim
do
  ln -sf $DIR/$i ~/.$i
done

