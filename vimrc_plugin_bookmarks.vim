
Plugin 'MattesGroeger/vim-bookmarks'
nmap <M-b>m <Plug>BookmarkToggle
nmap <M-b>a <Plug>BookmarkAnnotate
nmap <M-b>n <Plug>BookmarkNext
nmap <M-b>p <Plug>BookmarkPrev
nmap <M-b>i <Plug>BookmarkShowAll
nmap <M-b>c <Plug>BookmarkClear
nmap <M-b>x <Plug>BookmarkClearAll
if has("win32") || has("win64")
    " can't get unicode to work correctly on windows :(
    let g:bookmark_sign = '**'
    let g:bookmark_annotation_sign = '##'
endif
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_manage_per_buffer = 1
