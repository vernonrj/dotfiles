"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim configuration file
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


"----------------------------------------------------------"
" Compatibility
"----------------------------------------------------------"
if has('nvim')
    runtime! python_setup.vim
endif

if !exists('g:vimrc_rsa_1es')
    " tab length and other settings
    let g:vimrc_rsa_1es=0
endif

"----------------------------------------------------------"
" Bundle Configuration
"----------------------------------------------------------"

if !exists('g:vimrc_bundle_c')
    " c-like language plugins
    let g:vimrc_bundle_c=0
endif

if !exists('g:vimrc_bundle_lisp')
    " lisp-related plugins
    let g:vimrc_bundle_lisp=0
endif

if !exists('g:vimrc_bundle_airline')
    " heavier statusline
    let g:vimrc_bundle_airline=1
endif

if !exists('g:vimrc_bundle_ycm')
    " heavier, more complex fuzzy completion (if on, turns on syntastic too)
    " if off, turns on supertab
    let g:vimrc_bundle_ycm=0
endif

if !exists('g:vimrc_bundle_syntastic')
    " syntax checking
    let g:vimrc_bundle_syntastic=0
endif

if !exists('g:vimrc_bundle_windows_dev')
    " work/windows plugins
    let g:vimrc_bundle_windows_dev=0
endif

if !exists('g:vimrc_bundle_command_t')
    " Use ctrlp by default
    let g:vimrc_bundle_command_t = 0
endif

"----------------------------------------------------------"
" General configuration
"----------------------------------------------------------"
if !has('nvim')
    set cryptmethod=blowfish
endif
set history=2000
set viminfo+=!             " Store upper-case registers in viminfo
set ssop+=globals
let g:netrw_liststyle=3
" set hidden                  " Buffers are not unloaded when hidden


"----------------------------------------------------------"
" Platform-Specific configuration
"----------------------------------------------------------"
if has("win32") || has("win64")
    " ==== Windows Configuration goes here ==== "

    " Language configuration
    if !has('nvim')
       set encoding=utf-8
       set langmenu=en_US.UTF-8
       language English_United States
    endif

    set guifont=Consolas:h11:cANSI
    behave xterm
    " Ensure various split commands work on windows
    " like :Gdiff
    set dir=c:\tmp
    " reloading mappings for vimrc on windows
    map <Leader>gv :source ~/_vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map <Leader>gV :e ~/_vimrc<CR>
    let g:bcomp_path = "C:\\Program Files (x86)\\Beyond Compare 4\\BComp.exe"

    " Disable annoying beeps in windows.
    set noerrorbells visualbell t_vb=

    nmap <X2Mouse> [[
    nmap <X1Mouse> ]]
else
    " reloading mappings for vimrc on *nix
    map <Leader>gv :source ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map <Leader>gV :e ~/.vimrc<CR>
    let g:bcomp_path = "bcompare"
endif

if !has("python") || has("nvim")
    let g:vimrc_bundle_ycm=0
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &term =~ "xterm"
    set term=xterm-256color
endif

"----------------------------------------------------------"
" Look And Feel
" Colors, Fonts, Syntax, Statuslines, etc
"----------------------------------------------------------"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lines
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=2
set display+=lastline
" Line Breaks
setlocal linebreak
"set textwidth=110
let &showbreak = '+++'  " Show line breaks using given symbol

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline=%{fugitive#statusline()}
set laststatus=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cinoptions+=(0



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Drawing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ttyfast
set lazyredraw


"----------------------------------------------------------"
" Window management
" Buffers, Splits, Tabs
"----------------------------------------------------------"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
if g:vimrc_rsa_1es == 1
    set tabstop=3
    set shiftwidth=3
else
    set tabstop=4
    set shiftwidth=4
endif
set smarttab



"----------------------------------------------------------"
" GUI elements
" Mouse, terminal config
"----------------------------------------------------------"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI menu config, cursor
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui')
    set guioptions=eg
    set guicursor+=a:blinkon0
endif

set ruler       " Show cursor position always
set showcmd     " Display incomplete terms


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mousehide
if has('mouse')
   if has("win32") || has("win64")
       " I always go into selection mode when I don't want to on windows.
       " So disable that feature on windows only
       set mouse=inchr
    else
        " Never had that problem on *nix though. No reason to disable there.
        set mouse=ra
    endif
endif



"----------------------------------------------------------"
" Search
" Searching, tags
"----------------------------------------------------------"

if executable('csearch')
    set grepprg=csearch\ -n
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incremental Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch   " Do incremental searching
set ignorecase
set smartcase


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make things like search wrap and other warnings way more obvious
highlight WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent/Completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('linebreak')
    " wrapping is indented to create blocks of text
    set breakindent
endif

" Tab completion on commands
set wildmode=longest,list,full
set wildmenu
set cpoptions=aABceFIs
if g:vimrc_rsa_1es == 1
    " some include lists are too large to allow sane scanning of include
    " lists. Turn it off
    set complete-=i
endif
" Compilation ignores
set wildignore+=*.dll,*.lib,*.pdb,*.org,*.tlb,*.obj,*.lnk,*.msi,*.exe
set wildignore+=*.rlib
set wildignore+=*.pyo,*.pyc,*.so,*.o
set wildignore+=*.class,*.properties,*.dependencies
" Pictures ignores
set wildignore+=*.bmp,*.ico,*.svg,*.png,*.gif
" Archives ignores
set wildignore+=*.zip,*.rar,*.tar,*.jar,*.tar.gz,*.tar.xz,*.tar.bz,*.7z
" Other ignores
set wildignore+=*.chm,*.ilk,*.dfl,*.ttf
set wildignore+=*.iqw,*.ibn,*.wv,*.vam,*.suo
set wildignore+=*.doc,*.docx,*.xls,*.xlsx


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ensure backspace works like expected on tabs
set backspace=indent,eol,start


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File change watching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=marker


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only use these commands when compiled with support for autocommands
augroup vimrcExtraSyntax
    autocmd!
    " autocmd BufEnter * :syntax sync fromstart
    autocmd FileType python setlocal shiftwidth=4 tabstop=4
    autocmd FileType vim setlocal shiftwidth=4 tabstop=4
    autocmd FileType org setlocal shiftwidth=4 tabstop=4
augroup END

augroup vimrcExtraFileTypes
    autocmd!
    autocmd BufRead,BufNewFile *.json set filetype=json
    autocmd BufRead,BufNewFile *.ps1 set filetype=ps1
    autocmd BufRead,BufNewFile *.log set filetype=log
    if g:vimrc_rsa_1es == 1
        autocmd BufRead,BufNewFile *.cmd set filetype=iecwin
        autocmd BufRead,BufNewFile *.inp set filetype=iecwin
        " autocmd FileType iecwin set syntax=cpp
    endif
augroup END


augroup vimrcEx
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \    exe "normal! g`\"" |
                \ endif
    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

augroup END

if has("win32") || has("win64")
    augroup vimrcWindows
        autocmd!
        autocmd GUIEnter * set visualbell t_vb=
    augroup END
endif




" Diff original file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis

" Search quickfix window
function! GrepQuickFix(pat)
  let all = getqflist()
  for d in all
    if bufname(d['bufnr']) !~ a:pat && d['text'] !~ a:pat
        call remove(all, index(all,d))
    endif
  endfor
  call setqflist(all)
endfunction
command! -nargs=* GrepQF call GrepQuickFix(<q-args>)

function! RemoveQuickFix(pat)
  let all = getqflist()
  for d in all
    if bufname(d['bufnr']) =~ a:pat || d['text'] =~ a:pat
        call remove(all, index(all,d))
    endif
  endfor
  call setqflist(all)
endfunction
command! -nargs=* RemoveQF call RemoveQuickFix(<q-args>)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Beyond Compare Integration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! BCompAdd()
    let g:bcomp_file = expand('%:p')
endfunction
command! -nargs=* -complete=file BCompAdd call BCompAdd()
function! BComp()
    if !exists('g:bcomp_file')
        let g:bcomp_file = ""
    endif
    let thisfile = ''.expand('%:p')
    echo("Compare ".thisfile." ".g:bcomp_file)
    exec("silent !\"".g:bcomp_path."\" \"".thisfile."\" \"".g:bcomp_file."\"")
endfunction
command! -nargs=* -complete=file BComp call BComp()



"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Mappings
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoremap <Space> :
" nnoremap <S-Space> :

cnoremap <M-5> <C-R>=expand('%:p:h')<CR>/
cnoremap <M-2> <C-R>=expand('%:p')<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight current search
nnoremap <silent> <BS> :set hlsearch! hlsearch?<CR>

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
" nnoremap <silent> 0 :call SmartLineBegin()<CR>
" nnoremap ^ 0
nnoremap g0 g^
nnoremap g^ g0
" Remap home/end keys to act like windows text editors when lines wrap
" nnoremap <Home> g0
nnoremap <End> g$
" Highlight last pasted text
nmap <silent> gb `[v`]

" Some readline functions
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-b> <Left>
noremap! <C-f> <Right>
noremap! <M-b> <S-Left>
noremap! <M-f> <S-Right>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F1> <nop>
nnoremap K <nop>



"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Plugins
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


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

" Movement
Plugin 'vim-scripts/matchit.zip'

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
Plugin 'tpope/vim-repeat'
Plugin 'tComment'                           " better commenting


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

call vundle#end()

" vim:ft=vim:ts=4:sw=4:
