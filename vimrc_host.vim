"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim configuration file
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"----------------------------------------------------------"
" Compatibility
"----------------------------------------------------------"
set nocompatible


" tab length and other settings
let g:vimrc_rsa_1es=0

"----------------------------------------------------------"
" Bundle Configuration
"----------------------------------------------------------"
" colorscheme (zenburn or solarized)
let g:vimrc_bundle_color='solarized'
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

source ~/dotfiles/vimrc

" vim:ft=vim:ts=4:sw=4:
