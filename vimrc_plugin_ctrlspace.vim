
Plugin 'szw/vim-ctrlspace'
if has("win32") || has("win64")
    " Can't get unicode font to work correctly...
    let g:ctrlspace_unicode_font = 0
endif
if executable("ag")
    let g:ctrlspace_glob_command = 'ag -l --nocolor -g ""'
endif
