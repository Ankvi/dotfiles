set encoding=utf-8
set nocompatible
" filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'valloric/youcompleteme'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()

filetype plugin indent on
syntax on
set relativenumber
set numberwidth=3

nmap J "mzJ`z"
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap n "nzzzv"
nmap N "Nzzzv"

vmap J ":m '>+1<CR>gv=gv"
vmap K ":m '<-2<CR>gv=gv"
