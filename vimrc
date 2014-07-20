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



set cryptmethod=blowfish
set history=2000
set viminfo+=!             " Store upper-case registers in viminfo
set ssop+=globals
let g:netrw_liststyle=3


if has("win32") || has("win64")
    " ==== Windows Configuration goes here ==== "

    " Language configuration
    set langmenu=en_US.UTF-8
    language English_United States

    set guifont=Consolas:h11:cANSI
    behave xterm
    " Ensure various split commands work on windows
    " like :Gdiff
    " set directory+=,~/tmp,$TMP
    set dir=c:\tmp
    " Disable YCM on windows because it's too difficult
    " to get up and running
    let g:vimrc_bundle_ycm=0
    " reloading mappings for vimrc on windows
    map <Leader>gv :source ~/_vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map <Leader>gV :e ~/_vimrc<CR>
    let g:bcomp_path = "C:\\Program Files (x86)\\Beyond Compare 3\\BComp.exe"

    " Can't get unicode font to work correctly...
    let g:ctrlspace_unicode_font = 0
else
    " reloading mappings for vimrc on *nix
    map <Leader>gv :source ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map <Leader>gV :e ~/.vimrc<CR>
    let g:bcomp_path = "bcompare"
endif


" includes
let g:vimrc_sourced_files = {}
if filereadable(expand('~/dotfiles/vimrc'))
    let g:vimrc_resource_path = expand('~/dotfiles')
elseif filereadable('vimrc')
    let g:vimrc_resource_path = expand('.')
else
    echoerr("Can't find vimrc resource files, some functionality may be missing")
endif

if exists('g:vimrc_resource_path')
    exec("source " . g:vimrc_resource_path . "/vimrc_functions.vim")
    exec("source " . g:vimrc_resource_path . "/vimrc_mappings.vim")
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
set so=2
" Line Breaks
setlocal lbr
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
autocmd BufEnter * :syntax sync fromstart
syntax enable
set cino+=(0



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
" GUI menu config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions=eg

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor/Mouse
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guicursor+=a:blinkon0
set ruler   " Show cursor position always
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incremental Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showcmd     " Display incomplete terms
set incsearch   " Do incremental searching
set ignorecase
set smartcase


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make things like search wrap and other warnings way more obvious
hi WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent/Completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set wildignore+=*.pyo,*.pyc,*.so,*.o
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




"----------------------------------------------------------"
" Plugins
"----------------------------------------------------------"
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

" Vundle
Plugin 'gmarik/vundle'

"## Functionality inspired by other editors ##

Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_next_key='<M-n>'
let g:multi_cursor_prev_key='<M-S-n>'
let g:multi_cursor_skip_key='<M-m>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

Plugin 'chrisbra/NrrwRgn'



"## Vim feature enhancement ##
" Session
Plugin 'szw/vim-ctrlspace'
" Plugin 'tpope/vim-obsession'        " Better :mksession

" Movement
Plugin 'EasyMotion'                 " Easier movement
Plugin 'tpope/vim-rsi'              " readline in insert mode
Plugin 'vim-scripts/matchit.zip'

" File/Directory/Buffer
Plugin 'scrooloose/nerdtree'
nmap <silent> <F6> :NERDTreeToggle<CR>
nmap <silent> <C-F6> :NERDTreeFind<CR>
let NERDTreeDirArrows=0
let NERDTreeIgnore=['\.vim$', '\~$', '\.o', '\.gch', '\.am', '\.in']

" Ctrlp
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
nnoremap <C-n> :CtrlPMRU<CR>
nnoremap <M-p> :CtrlP .<CR>
noremap <Leader>bt :CtrlPTag<CR>
" noremap <Leader>r :CtrlPLastMode<CR>
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
if executable('ag')
    " Use ag for grep and ctrlp
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Buffer explorer
"Plugin 'bufexplorer.zip'

" Editing
Plugin 'tpope/vim-surround'         " Surrounding movements
Plugin 'wellle/targets.vim'         " Many more movements
Plugin 'tpope/vim-repeat'
Plugin 'tComment'                   " better commenting
Plugin 'godlygeek/tabular'          " Text alignment
map <Leader>gt= :Tabularize /=<CR>
map <Leader>gt: :Tabularize /:<CR>
map <Leader>gt:: :Tabularize /:\zs<CR>
map <Leader>gt, :Tabularize /,<CR>
map <Leader>gt<Bar> :Tabularize /<Bar><CR>
map <Leader>gtm :Tabularize /m_.*<CR>
map <leader>gT :Tabularize /

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger='<c-k>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'

Plugin 'agassiyzh/Mark--Karkat'
let g:mvDefaultHighlightingPalette = 'extended'
nmap <k0> <Plug>MarkSearchAnyNext
nmap <C-k0> <Plug>MarkSearchAnyPrev

Plugin 'MattesGroeger/vim-bookmarks'
nmap <M-b>m <Plug>ToggleBookmark
nmap <M-b>a <Plug>Annotate
nmap <M-b>n <Plug>NextBookmark
nmap <M-b>p <Plug>PrevBookmark
nmap <M-b>i <Plug>ShowAllBookmarks
nmap <M-b>c <Plug>ClearBookmarks
nmap <M-b>x <Plug>ClearAllBookmarks
if has("win32") || has("win64")
    " can't get unicode to work correctly on windows :(
    let g:bookmark_sign = '**'
    let g:bookmark_annotation_sign = '##'
endif



"## Look And Feel ##

" Statusbar
Plugin 'bling/vim-airline'

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

" Zenburn
" Plugin 'Zenburn'
let g:zenburn_high_Contrast=1

if g:vimrc_bundle_color == 'solarized'
    if has('gui_running')
        colorscheme solarized
    else
        colorscheme zenburn
    endif
elseif g:vimrc_bundle_color == 'zenburn'
    colorscheme zenburn
    " Fix some weird urxvt behavior
    "hi TabLineFill cterm=none
else
    exec("colorscheme ".g:vimrc_bundle_color)
endif




" ## External programs ##

" git integration
Plugin 'tpope/vim-fugitive'

" Compilation
Plugin 'tpope/vim-dispatch'         " Better :make

" Searching
Plugin 'rking/ag.vim'               " Better ack
" Plugin 'mileszs/ack.vim'            " Better vimgrep



" ## Optional Plugins ##

if g:vimrc_bundle_c == 1
    " C/C++ related plugins
    Plugin 'a.vim'
    Plugin 'majutsushi/tagbar'
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
    Plugin 'guns/paredit'
    Plugin 'tpope/vim-fireplace'
    Plugin 'tpope/vim-classpath'
    Plugin 'guns/vim-clojure-static'
endif


if g:vimrc_bundle_ycm == 1
    " use heavier YCM for completion
    Plugin 'Valloric/YouCompleteMe'
    let g:ycm_key_invoke_completion = '<C-y>'
    let g:ycm_confirm_extra_conf = 0
    "let g:ycm_filetype_blacklist = { 'python': 1}
    let g:ycm_autoclose_preview_window_after_insertion = 1
    " use syntastic too
    let g:vimrc_bundle_syntastic=1
elseif has('lua')
    " Use neocomplete if we have lua
    Plugin 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
    inoremap <expr><Tab>
    \ neocomplete#complete_common_string() != '' ?
    \   neocomplete#complete_common_string() :
    \ pumvisible() ? "\<C-n>" : "\<Tab>"
else
    " use supertab for completion
    Plugin 'ervandew/supertab'
    let g:SuperTabNoCompleteAfter = ['=', '+']
    let g:SuperTabNoCompleteAfter += ['[', '(', '{']
    let g:SuperTabNoCompleteAfter += [']', ')', '}']
    let g:SuperTabNoCompleteAfter += [',', ';', '&', '^', '\s']
    set completeopt+=longest
endif

if g:vimrc_bundle_syntastic == 1
    " Add syntax checking
    Plugin 'scrooloose/syntastic'
    let g:syntastic_cpp_compiler_options = ' -std=c++11'
    let g:syntastic_python_checkers = ['pylint']
    let g:syntastic_cpp_checkers = ['cppcheck', 'gcc']
    nnoremap <F5> :SyntasticCheck<CR>
    nnoremap <C-F5> :SyntasticToggleMode<CR>
    nnoremap <C-S-F5> :SyntasticReset<CR>
endif


if g:vimrc_bundle_windows_dev == 1
    " Make Wandows work ngrmadly

    " ClearCase integration
    if g:vimrc_rsa_1es == 1
        Plugin 'vim-scripts/ccase.vim'
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





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only use these commands when compiled with support for autocommands
if has("autocmd")
    filetype plugin indent on

    au BufRead,BufNewFile *.json set filetype=json
    au BufRead,BufNewFile *.ps1 set filetype=ps1
    if g:vimrc_rsa_1es == 1
        au BufRead,BufNewFile *.cmd set filetype=iecwin
        au FileType iecwin set syntax=cpp
    endif
    au FileType python setlocal shiftwidth=4 tabstop=4
    au FileType vim setlocal shiftwidth=4 tabstop=4
    " Put these in an autocmd group, so that we can delete them easily. (?)
    augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \    exe "normal! g`\"" |
      \ endif
   augroup END

   " Instead of reverting the cursor to the last position in the buffer, we
   " set it to the first line when editing a git commit message
   au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
else
   set autoindent
endif





" vim:ft=vim:ts=4:sw=4:
