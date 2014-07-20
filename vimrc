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


"----------------------------------------------------------"
" General configuration
"----------------------------------------------------------"
set cryptmethod=blowfish
set history=2000
set viminfo+=!             " Store upper-case registers in viminfo
set ssop+=globals
let g:netrw_liststyle=3


"----------------------------------------------------------"
" Platform-Specific configuration
"----------------------------------------------------------"
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
else
    " reloading mappings for vimrc on *nix
    map <Leader>gv :source ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map <Leader>gV :e ~/.vimrc<CR>
    let g:bcomp_path = "bcompare"
endif


"----------------------------------------------------------"
" Include extra files
"----------------------------------------------------------"
let g:vimrc_sourced_files = {}
if filereadable(expand('~/dotfiles/vimrc'))
    let g:vimrc_resource_path = expand('~/dotfiles')
elseif filereadable('vimrc')
    let g:vimrc_resource_path = expand('.')
else
    echoerr("Can't find vimrc resource files, some functionality may be missing")
endif

if exists('g:vimrc_resource_path')
    for myfile in s:vimrc_files_to_source
        exec("source " . g:vimrc_resource_path . "/" . myfile)
    endfor
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
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
