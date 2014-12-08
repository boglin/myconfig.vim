" Bootstrap for myconfig, start vundle and load plugins.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/

call vundle#begin()

" Load our config
Plugin 'boglin/myconfig.vim'

" Load plugins
Plugin 'gmarik/vundle'
Plugin 'sjl/gundo.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'

call vundle#end()

" :END OF FILE: All config should be in plugins
