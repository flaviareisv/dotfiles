#!/bin/bash

DIR_CONFIG=$HOME/dotfiles

echo "Configurações de Setup - Profile"

if [ -f "$HOME/.profile" ]
then
    FILE_PROFILE=$HOME/.profile
elif [ -f "$HOME/.bash_profile" ]
then
    FILE_PROFILE=$HOME/.bash_profile
fi

if [ -f "$FILE_PROFILE" ]
then
    echo ". $DIR_CONFIG/profile" >> $FILE_PROFILE
else
    echo "Profile não encontrado"
fi

echo "Configurações VIM"

cp $DIR_CONFIG/vim/.vimrc $HOME/.
cp $DIR_CONFIG/vim/vundles.vim $HOME/.vim

echo "Configurações GIT"

cp $DIR_CONFIG/git/.gitconfig $HOME/.

echo "Done"
