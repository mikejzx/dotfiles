" Load vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Load clipboard
let g:loaded_clipboard_provider = 1
set clipboard=unnamedplus
