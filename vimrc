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
" General configuration
"----------------------------------------------------------"
if !has('nvim')
    set cryptmethod=blowfish
endif
set history=2000
set viminfo+=!             " Store upper-case registers in viminfo
set sessionoptions+=globals
set sessionoptions-=options
set sessionoptions-=curdir
let g:netrw_liststyle=3


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

    if &term == "win32"
        set ttyscroll=0
        set term=xterm
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
    let g:bcomp_path = "C:\\Program Files\\Beyond Compare 4\\BComp.exe"

    " Disable annoying beeps in windows.
    set noerrorbells visualbell t_vb=

    nmap <X2Mouse> [[
    nmap <X1Mouse> ]]
    " if has('terminal')
    "     set shell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
    "     set shellcmdflag=-NoLogo\ -NoProfile\ -NonInteractive\ -Command
    "     set shellquote=\"
    "     set shellxquote=
    " endif
else
    " reloading mappings for vimrc on *nix
    map <Leader>gv :source ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map <Leader>gV :e ~/.vimrc<CR>
    let g:bcomp_path = "bcompare"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &term =~ "xterm" && !has('win32') && !has('win64')
    set term=xterm-256color
endif

"----------------------------------------------------------"
" Look And Feel
" Colors, Fonts, Syntax, Statuslines, etc
"----------------------------------------------------------"

set scrolloff=2
set display+=lastline
setlocal linebreak      " Some better linebreak behavior
"set textwidth=110
let &showbreak = '+++'  " Show line breaks using given symbol
set laststatus=2        " sane statusline
set cinoptions+=(0      " re-indent how I like
set ttyfast             " go faster
set lazyredraw          " go faster!


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright           " as in, 'that's how split is supposed to work'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab            " no tabs allowed
if g:vimrc_rsa_1es == 1
    set tabstop=3
    set shiftwidth=3
else
    set tabstop=4
    set shiftwidth=4
endif
set smarttab              " be a bit smarter

if has('gui')
    set guioptions=eg
    set guicursor+=a:blinkon0   " I hate blinking cursors
endif

set ruler       " Show cursor position always
set showcmd     " Display incomplete terms


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


set incsearch
set ignorecase
set smartcase
if executable('rg')
    set grepprg=rg\ --vimgrep
elseif executable('ag')
    set grepprg=ag\ --vimgrep
endif


if has('linebreak')
    set breakindent
    set linebreak
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
set wildignore+=*/target/*,*/node_modules/*
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
set wildignore+=*.rs.bk



set backspace=indent,eol,start

set autoread

set foldmethod=marker


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
    autocmd BufRead,BufNewFile *.md set filetype=markdown
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
    " No, I don't want to hear when tab completion fails
    augroup vimrcWindows
        autocmd!
        autocmd GUIEnter * set visualbell t_vb=
    augroup END
endif




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
nnoremap <silent> 0 ^
nnoremap ^ 0
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


if exists('g:vimrc_vundle_install_path')
    call vundle#begin(g:vimrc_vundle_install_path)
else
    call vundle#begin()
endif

" Vundle
Plugin 'gmarik/vundle'
" Movement
Plugin 'vim-scripts/matchit.zip'
Plugin 'vernonrj/vim-lasttab'
" Editing
Plugin 'tpope/vim-surround'                 " Surrounding movements
Plugin 'tpope/vim-repeat'
Plugin 'tComment'                           " better commenting
Plugin 'vernonrj/vim-smarthome'
Plugin 'tommcdo/vim-exchange'

map <silent> 0 :call SmartLineBegin()<CR>

if has('gui_running') || !(has("win32") || has("win64"))
    Plugin 'vernonrj/Mark--Karkat'
    let g:mwDefaultHighlightingPalette = 'maximum'
    let g:mwDefaultHighlightingNum = 12
    nmap <k0> <Plug>MarkSearchAnyNext
    nmap <C-k0> <Plug>MarkSearchAnyPrev
    nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
    nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
endif

Plugin 'bronson/vim-visual-star-search'


Plugin 'bling/vim-airline'
let g:airline#extensions#whitespace#enabled = 0
if g:vimrc_rsa_1es == 1
    let g:airline#extensions#branch#enabled = 0
endif
" Syntax highlighting
Plugin 'elzr/vim-json'              " json syntax highlighting
let g:vim_json_syntax_conceal = 0
" Colorscheme / Look-and-feel
Plugin 'flazz/vim-colorschemes'

set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"


" ## External programs ##
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'         " Better :make
" Plugin 'mileszs/ack.vim'            " Better grep
" if executable('rg')
"     let g:ackprg = 'rg --column -n'
" elseif executable('ag')
"     let g:ackprg = 'ag --vimgrep'
" endif
" Bundle 'chrisbra/vim-diff-enhanced'

" use supertab for fallback completion
Plugin 'ervandew/supertab'
let g:SuperTabNoCompleteAfter = ['=', '+']
let g:SuperTabNoCompleteAfter += ['[', '(', '{']
let g:SuperTabNoCompleteAfter += [']', ')', '}']
let g:SuperTabNoCompleteAfter += [',', ';', '&', '^', '\s']
set completeopt+=longest


if has('nvim')
    Plugin 'benekastah/neomake'
endif

Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'

call vundle#end()

" vim:ft=vim:ts=4:sw=4:
