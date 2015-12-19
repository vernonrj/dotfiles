"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim configuration file
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

set nocompatible
filetype off


" tab length and other settings
let g:vimrc_rsa_1es=0

source ~/dotfiles/vimrc

source ~/dotfiles/vimrc_plugin_bookmarks.vim
" source ~/dotfiles/vimrc_plugin_ctrlspace.vim
source ~/dotfiles/vimrc_plugin_obsession.vim
source ~/dotfiles/vimrc_plugin_taboo.vim
source ~/dotfiles/vimrc_plugin_multiple_cursors.vim
source ~/dotfiles/vimrc_plugin_syntastic.vim
source ~/dotfiles/vimrc_plugin_ycm.vim
source ~/dotfiles/vimrc_plugin_windows.vim

source ~/dotfiles/vimrc_plugin_language_c.vim
" source ~/dotfiles/vimrc_plugin_language_lisp.vim

source ~/dotfiles/vimrc_plugin_ctrlp.vim
" source ~/dotfiles/vimrc_plugin_command_t.vim

filetype plugin indent on
syntax enable

colorscheme darkburn

" Make things like search wrap and other warnings way more obvious
highlight WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None

" vim:ft=vim:ts=4:sw=4:
