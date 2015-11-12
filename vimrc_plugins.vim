"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim plugin file
"
" This contains all Plugins
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if !exists('g:vimrc_sourced_files')
    let g:vimrc_sourced_files = {}
endif
if has_key(g:vimrc_sourced_files, 'plugins')
    finish
endif
let g:vimrc_sourced_files['plugins'] = 1

"----------------------------------------------------------"
" Plugins
"----------------------------------------------------------"
set runtimepath+=~/.vim/bundle/vundle
call vundle#begin()

" Vundle
Plugin 'gmarik/vundle'


"## Functionality inspired by other editors ##

Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" Plugin 'chrisbra/NrrwRgn'



"## Vim feature enhancement ##
" Session
Plugin 'szw/vim-ctrlspace'
if has("win32") || has("win64")
    " Can't get unicode font to work correctly...
    let g:ctrlspace_unicode_font = 0
endif
if executable("ag")
    let g:ctrlspace_glob_command = 'ag -l --nocolor -g ""'
endif
" let g:ctrlspace_default_mapping_key = "<Space>"
" nnoremap <C-Space> :CtrlSpace<CR>l

" Movement
" Plugin 'EasyMotion'                 " Easier movement
" Plugin 'tpope/vim-rsi'              " readline in insert mode
Plugin 'vim-scripts/matchit.zip'

" File/Directory/Buffer
" Plugin 'scrooloose/nerdtree'
" nmap <silent> <F6> :NERDTreeToggle<CR>
" nmap <silent> <C-F6> :NERDTreeFind<CR>
" let NERDTreeDirArrows=0
" let NERDTreeIgnore=['\.vim$', '\~$', '\.o', '\.gch', '\.am', '\.in']

if g:vimrc_bundle_command_t == 0 || !has('ruby')
    " Ctrlp
    " Plugin 'kien/ctrlp.vim'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'FelikZ/ctrlp-py-matcher'
    nnoremap <C-n> :CtrlPMRU<CR>
    nnoremap <M-p> :CtrlP .<CR>
    noremap <Leader>bt :CtrlPTag<CR>
    noremap <Leader><C-p> :CtrlPMixed<CR>
    noremap <Leader><C-b> :CtrlPBookmarkDir<CR>
    noremap <Leader><C-d> :CtrlPBookmarkDirAdd<CR>
    let g:ctrlp_prompt_mappings = { 'ToggleMRURelative()': ['<F2>']}
    if g:vimrc_rsa_1es == 1
        " handle large projects better
        let g:ctrlp_root_markers = ['build']
    endif
    let g:ctrlp_max_files = 0
    let g:ctrlp_lazy_update = 1
    if has('python')
        let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    endif
else
    " Command-T
    " faster than ctrl-p, but more difficult to set up
    Plugin 'wincent/command-t'

    let g:CommandTMaxCachedDirectories = 5
    let g:CommandTMatchWindowReverse = 1
    let g:CommandTMaxHeight = 20

    if vimrc_rsa_1es == 1
        let g:CommandTMaxFiles = 1000000
        let g:CommandTSCMDirectories = '.git,.hg,.svn,.bzr,_darcs,build'
    endif

    nnoremap <silent> <C-p> :CommandT<CR>
    nnoremap <silent> <M-p> :CommandT .<CR>

    if executable('watchman')
        let g:CommandTFileScanner = 'watchman'
    endif
endif

" Editing
Plugin 'tpope/vim-surround'                 " Surrounding movements
" Plugin 'wellle/targets.vim'                 " Many more movements
Plugin 'tpope/vim-repeat'
Plugin 'tComment'                           " better commenting


" if has('python')
"     if !has('nvim')
"         " Snippets
"         Plugin 'SirVer/ultisnips'
"         Plugin 'honza/vim-snippets'
"         let g:UltiSnipsExpandTrigger='<c-k>'
"         let g:UltiSnipsJumpForwardTrigger='<c-b>'
"         let g:UltiSnipsJumpBackwardTrigger='<c-z>'
"         let g:UltiSnipsEditSplit='vertical'
"     endif
" endif

if has('gui_running') || !(has("win32") || has("win64"))
    Plugin 'vernonrj/Mark--Karkat'
    let g:mwDefaultHighlightingPalette = 'maximum'
    let g:mwDefaultHighlightingNum = 12
    nmap <k0> <Plug>MarkSearchAnyNext
    nmap <C-k0> <Plug>MarkSearchAnyPrev
    nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
    nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
endif

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

" Plugin 'osyo-manga/vim-brightest'
" BrightestDisable
" let g:brightest#enable_on_CursorHold = 1

" Plugin 'dahu/vim-lotr'

"## Look And Feel ##

" Statusbar
if g:vimrc_bundle_airline == 1
    Plugin 'bling/vim-airline'
    let g:airline#extensions#whitespace#enabled = 0
    if g:vimrc_rsa_1es == 1
        let g:airline#extensions#branch#enabled = 0
    endif
else
    Plugin 'itchyny/lightline.vim'
    let g:lightline = {
                \ 'colorscheme': 'solarized',
                \ 'active': {
                \   'right': [
                \       [ 'syntastic', 'lineinfo'],
                \       [ 'percent' ],
                \       ['fileformat', 'fileencoding', 'filetype'],
                \       [ 'tagbar' ]
                \   ]
                \ },
                \ 'component': {
                \   'readonly': '%{&readonly?"RO":""}',
                \ },
                \ 'component_function': {
                \   'tagbar': 'TagbarStatusFunc'
                \ }
                \ }
    set noshowmode
endif


function! TagbarStatusFunc()
    return tagbar#currenttag('%s','')
endfunction

" Syntax highlighting
Plugin 'elzr/vim-json'              " json syntax highlighting
let g:vim_json_syntax_conceal = 0


" Colorscheme / Look-and-feel
Plugin 'flazz/vim-colorschemes'

" Solarized
" Plugin 'altercation/vim-colors-solarized'
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"


" ## External programs ##

" git integration
Plugin 'tpope/vim-fugitive'

" Compilation
Plugin 'tpope/vim-dispatch'         " Better :make

" Searching
Plugin 'rking/ag.vim'               " Better ack
" Plugin 'mileszs/ack.vim'            " Better vimgrep

" * and # searching
Bundle 'bronson/vim-visual-star-search'

" Bundle 'chrisbra/vim-diff-enhanced'

" ## Optional Plugins ##

if g:vimrc_bundle_c == 1
    " C/C++ related plugins
    Plugin 'a.vim'
    Plugin 'majutsushi/tagbar'
    augroup vimrcPluginTagbarExtra
        autocmd!
        autocmd FileType qf let b:tagbar_ignore = 1
    augroup END
    let g:tagbar_sort=0
    let g:tagbar_type_idl = {
        \ 'ctagstype' : 'idl',
        \ 'kinds'     : [
            \ 'i:interface'
        \ ],
        \ 'sort'      : 0
        \ }
    nmap <silent> <F7> :TagbarToggle<CR>
    Plugin 'steffanc/cscopemaps.vim'
    Plugin 'octol/vim-cpp-enhanced-highlight'
endif

if g:vimrc_bundle_lisp == 1
    " Load bundles related to LISP coding
    " Plugin 'guns/paredit'
    Plugin 'tpope/vim-fireplace'
    Plugin 'tpope/vim-classpath'
    Plugin 'guns/vim-clojure-static'
endif


if g:vimrc_bundle_ycm == 1
    " use heavier YCM for completion
    Plugin 'Valloric/YouCompleteMe'
    augroup vimrcYcm
        autocmd!
        autocmd BufReadPost *
                    \ if getfsize(expand('%')) > (g:ycm_disable_for_files_larger_than_kb * 1024) |
                    \   imap <buffer> <Tab> <Plug>SuperTabForward|
                    \   imap <buffer> <S-Tab> <Plug>SuperTabBackward|
                    \ endif
    augroup END
    let g:ycm_key_invoke_completion = '<C-y>'
    let g:ycm_confirm_extra_conf = 0
    "let g:ycm_filetype_blacklist = { 'python': 1}
    let g:ycm_autoclose_preview_window_after_insertion = 1
    " use syntastic too
    let g:vimrc_bundle_syntastic=1
    let g:ycm_filetype_blacklist = {
          \ 'tagbar' : 1,
          \ 'qf' : 1,
          \ 'notes' : 1,
          \ 'markdown' : 1,
          \ 'unite' : 1,
          \ 'text' : 1,
          \ 'vimwiki' : 1,
          \ 'pandoc' : 1,
          \ 'infolog' : 1,
          \ 'mail' : 1,
          \ 'log' : 1
          \}
    function! VimrcUseSupertab()
        setlocal completefunc=
        imap <buffer> <Tab> <Plug>SuperTabForward
        imap <buffer> <S-Tab> <Plug>SuperTabBackward
    endfunction
elseif has('lua')
    " Use neocomplete if we have lua
    Plugin 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
    inoremap <expr><Tab>
    \ neocomplete#complete_common_string() != '' ?
    \   neocomplete#complete_common_string() :
    \ pumvisible() ? "\<C-n>" : "\<Tab>"
endif

" use supertab for fallback completion
Plugin 'ervandew/supertab'
let g:SuperTabNoCompleteAfter = ['=', '+']
let g:SuperTabNoCompleteAfter += ['[', '(', '{']
let g:SuperTabNoCompleteAfter += [']', ')', '}']
let g:SuperTabNoCompleteAfter += [',', ';', '&', '^', '\s']
set completeopt+=longest

if g:vimrc_bundle_syntastic == 1
    " Add syntax checking
    Plugin 'scrooloose/syntastic'
    let g:syntastic_cpp_compiler_options = ' -std=c++11'
    let g:syntastic_python_checkers = ['pylint']
    let g:syntastic_cpp_checkers = ['cppcheck', 'gcc']
    if !exists('g:syntastic_mode_map')
        let g:syntastic_mode_map = {"mode": "active",
                    \ "active_filetypes": ["python"],
                    \ "passive_filetypes": []}
    endif
    nnoremap <F5> :SyntasticCheck<CR>
    nnoremap <C-F5> :SyntasticToggleMode<CR>
    nnoremap <C-S-F5> :SyntasticReset<CR>
    if g:vimrc_rsa_1es == 1
        let g:syntastic_mode_map["passive_filetypes"] += ["cpp"]
    endif
endif


if g:vimrc_bundle_windows_dev == 1
    " Make Wandows work ngrmadly

    " ClearCase integration
    if g:vimrc_rsa_1es == 1
        " Plugin 'vim-scripts/ccase.vim'
    endif
    " Visual Studio integration
    Plugin 'vim-scripts/visual_studio.vim'
    let g:visual_studio_output = "C:/temp/vs_output.txt"
    let g:visual_studio_task_list = "C:/temp/vs_task_list.txt"
    let g:visual_studio_find_results_1 = "C:/temp/vs_find_results_1.txt"
    let g:visual_studio_find_results_2 = "C:/temp/vs_find_results_2.txt"
    " Extra syntax highlighting
    Plugin 'PProvost/vim-ps1'
endif

if has('nvim')
    Plugin 'benekastah/neomake'
endif

Plugin 'tommcdo/vim-exchange'

" vim:ft=vim:ts=4:sw=4:
