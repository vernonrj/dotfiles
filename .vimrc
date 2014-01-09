"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim configuration file
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"----------------------------------------------------------"
" Compatibility
"----------------------------------------------------------"
set nocompatible


"----------------------------------------------------------"
" Bundle Configuration
"----------------------------------------------------------"
" colorscheme (zenburn or solarized)
let g:vimrc_bundle_color='zenburn'
" c-like language plugins
let g:vimrc_bundle_c=1
" lisp-related plugins
let g:vimrc_bundle_lisp=1
" statusbar plugin
let g:vimrc_bundle_airline=1
" heavier, more complex fuzzy completion (if on, turns on syntastic too)
" if off, turns on supertab
let g:vimrc_bundle_ycm=0
" syntax checking
let g:vimrc_bundle_syntastic=1
" extra undo functionality
let g:vimrc_bundle_undo=0
" git functionality
let g:vimrc_bundle_git=1
" CTRL-P replaces bufexplore
let g:vimrc_bundle_ctrlp=1

if has("win32") || has("win64")
    " ==== Windows Configuration goes here ==== "

    behave xterm
    " Ensure various split commands work on windows
    " like :Gdiff
    set directory+=,~/tmp,$TMP
    " Disable YCM on windows because it's too difficult
    " to get up and running
    let g:vimrc_bundle_ycm=0
    " reloading mappings for vimrc on windows
    map ,v :source ~/_vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map ,V :e ~/_vimrc<CR>
else
    " reloading mappings for vimrc on *nix
    map ,v :source ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>
    "Open .vimrc for editing
    map ,V :e ~/.vimrc<CR>
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
nnoremap <silent> <F3> :set nu!<CR> :set rnu!<CR>
nnoremap <silent> ,<F3> :set nornu<CR> :set nu!<CR>
"set nu
"set rnu
set so=2
" Line Breaks
setlocal lbr
"set textwidth=110
let &showbreak = '+++ '  " Show line breaks using given symbol

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell Checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ss :setlocal spell!<cr>
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline=%{fugitive#statusline()}
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F4> :if exists("syntax_on") <Bar>
    \   syntax off <Bar>
    \   set nonumber <Bar>
    \ else <Bar>
    \   syntax enable <Bar>
    \ endif <CR>


autocmd BufEnter * :syntax sync fromstart
syntax enable



"----------------------------------------------------------"
" Window management
" Buffers, Splits, Tabs
"----------------------------------------------------------"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers/Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remember info about open buffers on close
set viminfo^=%
map ,t :tab split<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab



"----------------------------------------------------------"
" GUI elements
" Mouse, terminal config
"----------------------------------------------------------"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scrollbars
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions=egmT

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor/Mouse
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guicursor+=a:blinkon0
set ruler   " Show cursor position always
set mousehide
if has('mouse')
    set mouse=ra
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" case sensitive/insensitive searches
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F2> :set ic! <CR>:set ic?<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,h :set hlsearch!<CR>
nnoremap ,c :set cursorline! cursorcolumn!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jumping (with menus)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>* :call <SID>JumpOccurrence()<CR>
nnoremap <Leader>? :call <SID>JumpPrompt()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump-searching (in blocks)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search within top-level block for word at cursor, or selected text.
nnoremap <Leader>[ /<C-R>=<SID>ScopeSearch('[[', 1)<CR><CR>
vnoremap <Leader>[ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>gV
" Search within current block for word at cursor, or selected text.
nnoremap <Leader>{ /<C-R>=<SID>ScopeSearch('[{', 1)<CR><CR>
vnoremap <Leader>{ <Esc>/<C-R>=<SID>ScopeSearch('[{', 2)<CR><CR>gV
" Search within current top-level block for user-entered text.
nnoremap <Leader>/ /<C-R>=<SID>ScopeSearch('[[', 0)<CR>
vnoremap <Leader>/ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Jumping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag jumping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <silent> <F11> :let fname = expand('%:p:h') . '/types.vim'<CR><F12>
" Just highlight tags based on existing tags.vim file.
":map <F12>  :so tags.vim<CR>
map <silent> <F12> :if filereadable(fname)<Bar>
    \   exe 'so ' . fname<CR>
    \ endif <CR>



"----------------------------------------------------------"
" Indent/Movement
"----------------------------------------------------------"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent/Completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab completion on commands
set wildmode=longest,list,full
set wildmenu
"set ci
set cpoptions=aABceFIs

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
nnoremap 0 ^
nnoremap ^ 0
nnoremap g0 g^
nnoremap g^ g0
" Remap home/end keys to act like windows text editors when lines wrap
nnoremap <Home> g0
nnoremap <End> g$
" ensure backspace works like expected on tabs
set backspace=indent,eol,start



"----------------------------------------------------------"
" Other Vanilla Configuration/Mappings
"----------------------------------------------------------"

"setlocal formatoptions=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File change watching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git commit filetype tweaks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=marker

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copying tweaks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>ac ggvG$"+y''

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pasting tweaks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap Y y$


" Diff original file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis

"----------------------------------------------------------"
" Plugins
"----------------------------------------------------------"
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

" Vundle
Bundle 'gmarik/vundle'

" Navigation
Bundle 'scrooloose/nerdtree'
nmap <silent> <F6> :NERDTreeToggle<CR>
let NERDTreeDirArrows=0
let NERDTreeIgnore=['\.vim$', '\~$', '\.o', '\.gch', '\.am', '\.in']

Bundle 'EasyMotion'
Bundle 'ack.vim'

" Editing
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-abolish'

" Commenting
Bundle 'tComment'

if g:vimrc_bundle_color == 'solarized'
    Bundle 'altercation/vim-colors-solarized'
    set background=dark
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    "let g:solarized_contrast="high"
    "let g:solarized_visibility="high"
    colorscheme solarized
elseif g:vimrc_bundle_color == 'zenburn'
    Bundle 'Zenburn'
    let g:zenburn_high_Contrast=1
    colorscheme zenburn
    " Fix some weird urxvt behavior
    "hi TabLineFill cterm=none
endif

if g:vimrc_bundle_c == 1
    Bundle 'a.vim'
    Bundle 'majutsushi/tagbar'
    nmap <silent> <F7> :TagbarToggle<CR>
    Bundle 'steffanc/cscopemaps.vim'
endif

if g:vimrc_bundle_lisp == 1
    " Load bundles related to LISP coding
    Bundle 'guns/paredit'
    Bundle 'tpope/vim-fireplace'
    Bundle 'tpope/vim-classpath'
    Bundle 'guns/vim-clojure-static'
    Bundle 'kien/rainbow_parentheses.vim'
endif

if g:vimrc_bundle_airline == 1
    " Add heavier statusbar
    Bundle 'bling/vim-airline'
endif

if g:vimrc_bundle_ycm == 1
    " use heavier YCM for completion
    Bundle 'Valloric/YouCompleteMe'
    let g:ycm_key_invoke_completion = '<C-y>'
    let g:ycm_confirm_extra_conf = 0
    "let g:ycm_filetype_blacklist = { 'python': 1}
    let g:ycm_autoclose_preview_window_after_insertion = 1
    nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
    " use syntastic too
    let g:vimrc_bundle_syntastic=1
else
    " use lighter supertab for completion
    Bundle 'ervandew/supertab'
    let g:SuperTabNoCompleteAfter = ['=', '+']
    let g:SuperTabNoCompleteAfter += ['[', '(', '{']
    let g:SuperTabNoCompleteAfter += [']', ')', '}']
    let g:SuperTabNoCompleteAfter += [',', ';', '&', '^', '\s']
    set completeopt+=longest
endif

if g:vimrc_bundle_syntastic == 1
    " Add syntax checking
    Bundle 'scrooloose/syntastic'
    let g:syntastic_cpp_compiler_options = ' -std=c++11'
    let g:syntastic_python_checkers = ['pylint']
    if g:vimrc_bundle_ycm == 0
        " Syntax check fallback
        nnoremap <F5> :SyntasticCheck<CR>
    endif
endif

if g:vimrc_bundle_undo == 1
    " Undo extensions
    Bundle 'mbbill/undotree'
    noremap U :UndotreeToggle<CR>
    set undodir='/home/vernon/.vim/undo/'
    set undofile
elseif g:vimrc_bundle_ctrlp == 1
    noremap U :CtrlPUndo<CR>
endif

if g:vimrc_bundle_git == 1
    " git integration
    Bundle 'tpope/vim-fugitive'
endif

if g:vimrc_bundle_ctrlp == 1
    " Ctrl-p extension
    Bundle 'kien/ctrlp.vim'
    nnoremap <C-n> :CtrlPBuffer<CR>
    nnoremap <leader>be :CtrlPMRU<CR>
else
    " Buffer explorer
    Bundle 'bufexplorer.zip'
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TurboMark
" - better mark functionality
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap <silent> mm :TurboMark<CR>
"nmap <silent> 'm :TurboFind<CR>




"----------------------------------------------------------"
" Helper Functions
"----------------------------------------------------------"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only use these commands when compiled with support for autocommands
if has("autocmd")
    filetype plugin indent on
    "set grepprg=grep\ -nH\ $*
    "let g:tex_flavor = "latex"

    " Put these in an autocmd group, so that we can delete them easily. (?)
    augroup vimrcEx
    au!

    " load the types.vim highlighting file, if it exists
    autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
    autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
    autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
    autocmd BufRead,BufNewFile *.[ch] endif

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
else
   set autoindent   " Always want that autoindent
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return a pattern to search within a specified scope, or
" return a backslash to cancel search if scope not found.
" navigator: a command to jump to the beginning of the desired scope
" mode: 0=scope only; 1=scope+current word; 2=scope+visual selection
function! s:ScopeSearch(navigator, mode)
  if a:mode == 0
    let pattern = ''
  elseif a:mode == 1
    let pattern = '\<' . expand('<cword>') . '\>'
  else
    let old_reg = getreg('@')
    let old_regtype = getregtype('@')
    normal! gvy
    let pattern = escape(@@, '/\.*$^~[')
    call setreg('@', old_reg, old_regtype)
  endif
  let saveview = winsaveview()
  execute 'normal! ' . a:navigator
  let first = line('.')
  normal %
  let last = line('.')
  normal %
  call winrestview(saveview)
  if first < last
    return printf('\%%>%dl\%%<%dl%s', first-1, last+1, pattern)
  endif
  return "\b"
endfunction


function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" List occurrences of keyword under cursor, and
" jump to selected occurrence.
function! s:JumpOccurrence()
  let v:errmsg = ""
  exe "normal [I"
  if strlen(v:errmsg) == 0
    let nr = input("Which one: ")
    if nr =~ '\d\+'
      exe "normal! " . nr . "[\t"
    endif
  endif
endfunction

" List occurrences of keyword entered at prompt, and
" jump to selected occurrence.
function! s:JumpPrompt()
  let keyword = input("Keyword to find: ")
  if strlen(keyword) > 0
    let v:errmsg = ""
    exe "ilist! " . keyword
    if strlen(v:errmsg) == 0
      let nr = input("Which one: ")
      if nr =~ '\d\+'
        exe "ijump! " . nr . keyword
      endif
    endif
  endif
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagging Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CtagTypeDefs()
    let fname = expand('%:p:h') . '/types.vim'
    let thisfile = expand("%:e")
    if filereadable(fname)
        exe 'so ' . fname
    elseif thisfile == "c"
        !ctags -R --c-kinds=gstu -o- *.[ch] | awk 'BEGIN{printf("syntax keyword Type\t")} {printf("\%s ",$$1)}END{print ""}' > types.vim
    endif
endfunction



