filetype off    " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" Plugins

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Config NERDTree
map <C-n> :NERDTreeToggle<CR>

" tab navigation
nnoremap <C-p> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-p> <Esc>:tabprevious<CR>i
inoremap <C-l> <Esc>:tabnext<CR>i
inoremap <C-t> <Esc>:tabnew<CR>

" Config syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
