" Extra plugins for C/C++

Plugin 'a.vim'
Plugin 'majutsushi/tagbar'
augroup vimrcPluginTagbarExtra
    autocmd!
    autocmd FileType qf let b:tagbar_ignore = 1
augroup END
let g:tagbar_sort=0
nmap <silent> <F7> :TagbarToggle<CR>
function! TagbarStatusFunc()
    return tagbar#currenttag('%s','')
endfunction

Plugin 'steffanc/cscopemaps.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'


