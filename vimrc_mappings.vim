"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim mapping file
"
" This contains my general keybindings. Plugin-specific
" keybindings are elsewhere
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

if !exists('g:vimrc_sourced_files')
    let g:vimrc_sourced_files = {}
endif
if has_key(g:vimrc_sourced_files, 'mappings')
    finish
endif
let g:vimrc_sourced_files['mappings'] = 1

exec("source " . expand('<sfile>:h') . '/vimrc_functions.vim')


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Space> :

cnoremap <M-5> <C-R>=expand('%:p:h')<CR>/
cnoremap <M-2> <C-R>=expand('%:p')<CR>
inoremap <C-t> <C-R>=strftime("TODO:vrj %Y.%m.%d: ")<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting/Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search
nnoremap <Leader>fi :set ignorecase! <CR>:set ignorecase?<CR>
cnoremap <M-4> \>
cnoremap <M-6> \<

" Line numbering
nnoremap <silent> <Leader>fn :set number!<CR> :set relativenumber!<CR>
nnoremap <silent> <Leader>fN :set norelativenumber<CR> :set number!<CR>

" Jumping (with menus)
" nnoremap <Leader>* :call <SID>JumpOccurrence()<CR>
" nnoremap <Leader>? :call <SID>JumpPrompt()<CR>

" Jump-searching (in blocks)
" Search within top-level block for word at cursor, or selected text.
nnoremap <Leader>[ /<C-R>=<SID>ScopeSearch('[[', 1)<CR><CR>
vnoremap <Leader>[ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>gV
" Search within current block for word at cursor, or selected text.
nnoremap <Leader>{ /<C-R>=<SID>ScopeSearch('[{', 1)<CR><CR>
vnoremap <Leader>{ <Esc>/<C-R>=<SID>ScopeSearch('[{', 2)<CR><CR>gV
" Search within current top-level block for user-entered text.
" nnoremap <Leader>/ /<C-R>=<SID>ScopeSearch('[[', 0)<CR>
" vnoremap <Leader>/ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>

" Visual Jumping
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight current search
nnoremap <silent> <Leader>hs :set hlsearch!<CR>:set hlsearch?<CR>
if !has('extra_search')
    call WarnFnNotAvailable('extra_search', 'search highlight toggle mapping')
endif

" highlight cursor line and cursor column
nnoremap <Leader>hc :set cursorline! cursorcolumn!<CR>
if !has('syntax')
    call WarnFnNotAvailable('syntax', 'cursorline/cursorcolumn toggle mapping')
endif

" highlight Syntax
nnoremap <silent> <Leader>hS :if exists("syntax_on") <Bar>
    \   syntax off <Bar>
    \   set nonumber <Bar>
    \ else <Bar>
    \   syntax enable <Bar>
    \ endif <CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers/Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remember info about open buffers on close
" set viminfo^=%
map <Leader>t :tab split<CR>
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt
if !has('windows')
    call WarnFnNotAvailable('windows', 'tab mappings')
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap navigation to act more like windows text editors when lines wrap
noremap <silent> j gj
noremap <silent> k gk
noremap <Up> gk
noremap <Down> gj
noremap gj j
noremap gk k
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj
" Remap 0/^ and related keys to how I like them
nnoremap <M-0> 0
nnoremap 0 ^
nnoremap ^ 0
nnoremap g0 g^
nnoremap g^ g0
" Remap home/end keys to act like windows text editors when lines wrap
nnoremap <Home> g0
nnoremap <End> g$
" Highlight last pasted text
nmap <silent> gb `[v`]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pasting tweaks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap Y y$


" vim:ft=vim:ts=4:sw=4:
