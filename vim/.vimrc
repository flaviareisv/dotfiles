set nocompatible    " be iMproved, required

" Vundle

if filereadable(expand("~/.vim/vundles.vim"))
    source ~/.vim/vundles.vim
endif

" Configuracao

syntax on

set showmatch       " mostra caracteres ( { [ quando fechados
set nu              " numeracao de linhas
set ts=4            " Seta onde o tab para
set sw=4            " largura do tab
set et              " espacos em vez de tab
set expandtab       " Tabs são convertidos para espaços
set shiftwidth=4    " autoindent com 4 espaços
set title           " mostra nome do arquivo no rodape
