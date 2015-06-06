"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim configuration file
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

set nocompatible
filetype off


" tab length and other settings
let g:vimrc_rsa_1es=0

"----------------------------------------------------------"
" Bundle Configuration
"----------------------------------------------------------"
" colorscheme (zenburn or solarized)
let g:vimrc_bundle_color='darkburn'
" c-like language plugins
let g:vimrc_bundle_c=0
" lisp-related plugins
let g:vimrc_bundle_lisp=0
" heavier, more complex fuzzy completion (if on, turns on syntastic too)
" if off, turns on supertab
let g:vimrc_bundle_ycm=0
" syntax checking
let g:vimrc_bundle_syntastic=0
" work/windows plugins
let g:vimrc_bundle_windows_dev=0
" Use command-t
let g:vimrc_bundle_command_t=1

source ~/dotfiles/vimrc

call vundle#end()

filetype plugin indent on
syntax enable

colorscheme darkburn

" vim:ft=vim:ts=4:sw=4:
