"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim configuration file
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"----------------------------------------------------------"
" Extra files (for reference)
"----------------------------------------------------------"
let s:vimrc_files_to_source = []
let s:vimrc_files_to_source += ['vimrc_functions.vim'] "~/dotfiles/vimrc_functions.vim
let s:vimrc_files_to_source += ['vimrc_mappings.vim']  "~/dotfiles/vimrc_mappings.vim
let s:vimrc_files_to_source += ['vimrc_plugins.vim']   "~/dotfiles/vimrc_plugins.vim
let g:vimrc_sourced_files = {}

"----------------------------------------------------------"
" Compatibility
"----------------------------------------------------------"
set nocompatible
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

if !exists('g:vimrc_bundle_color')
    " colorscheme (zenburn or solarized)
    let g:vimrc_bundle_color='solarized'
endif

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
    set encoding=utf-8
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
    "let g:vimrc_bundle_ycm=0
    " reloading mappings for vimrc on windows
    map <Leader>gv :source ~/_vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map <Leader>gV :e ~/_vimrc<CR>
    let g:bcomp_path = "C:\\Program Files (x86)\\Beyond Compare 4\\BComp.exe"

    " Disable annoying beeps in windows.
    set noerrorbells visualbell t_vb=

    if g:vimrc_rsa_1es == 1
        " Checking with PC-Lint
        function! PcLintSetup()
            set errorformat=
                        \%f(%l)\ :\ %t%*\\D%n:\ %m,
                        \%f(%l)\ :\ %m,
                        \%f(%l):%m,
                        \%D%f>%.%#nmake%.%#
            let &makeprg="cd %:h & makeit.bat /lnt %:t"
        endfunction
    endif
else
    " reloading mappings for vimrc on *nix
    map <Leader>gv :source ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map <Leader>gV :e ~/.vimrc<CR>
    let g:bcomp_path = "bcompare"
endif

if !has("python")
    let g:vimrc_bundle_ycm=0
endif


"----------------------------------------------------------"
" Include extra files
"----------------------------------------------------------"

for myfile in s:vimrc_files_to_source
    let file_to_source = expand('<sfile>:h') . "/" . myfile
    if filereadable(file_to_source)
        exec("source " . file_to_source)
    endif
endfor


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
syntax enable
if has('cindent')
    set cinoptions+=(0
else
    call WarnFnNotAvailable('cindent', ':set cinoptions')
endif



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
if has('cmdline_info')
    set ruler       " Show cursor position always
    set showcmd     " Display incomplete terms
else
    call WarnFnNotAvailable('cmdline_info', ':set ruler')
    call WarnFnNotAvailable('cmdline_info', ':set showcmd')
endif


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
if has('extra_search')
    set incsearch   " Do incremental searching
else
    call WarnFnNotAvailable('extra_search', ':set incsearch')
endif
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
if has("autocmd")
    filetype plugin indent on
else
    call WarnFnNotAvailable('autocmd', 'filetype plugin indent')
    set autoindent
endif
if has('linebreak')
    " wrapping is indented to create blocks of text
    set breakindent
endif

" Tab completion on commands
set wildmode=longest,list,full
if has('wildmenu')
    set wildmenu
else
    call WarnFnNotAvailable('wildmenu', ':set wildmenu')
endif
set cpoptions=aABceFIs
if g:vimrc_rsa_1es == 1
    " some include lists are too large to allow sane scanning of include
    " lists. Turn it off
    set complete-=i
endif
if has('wildignore')
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
else
    call WarnFnNotAvailable('wildignore', ':set wildignore')
endif


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
if has('folding')
    set foldmethod=marker
else
    call WarnFnNotAvailable('folding', ':set foldmethod')
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only use these commands when compiled with support for autocommands
if has("autocmd")
    augroup vimrcExtraSyntax
        autocmd!
        " autocmd BufEnter * :syntax sync fromstart
        autocmd FileType python setlocal shiftwidth=4 tabstop=4
        autocmd FileType vim setlocal shiftwidth=4 tabstop=4
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

else
    call WarnFnNotAvailable('autocmd', 'autocmd')
endif



" vim:ft=vim:ts=4:sw=4:
