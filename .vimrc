"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vernon Jones' vim configuration file
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"----------------------------------------------------------"
" Compatibility
"----------------------------------------------------------"
set nocompatible

set cryptmethod=blowfish
set history=2000
set viminfo+=!             " Store upper-case registers in viminfo
let g:netrw_liststyle=3

" tab length and other settings
let g:vimrc_rsa_1es=0

"----------------------------------------------------------"
" Bundle Configuration
"----------------------------------------------------------"
" colorscheme (zenburn or solarized)
let g:vimrc_bundle_color='solarized'
" c-like language plugins
let g:vimrc_bundle_c=1
" extra ctags plugins
let g:vimrc_extra_ctags=0
" lisp-related plugins
let g:vimrc_bundle_lisp=1
" statusbar plugin
let g:vimrc_bundle_airline=1
" heavier, more complex fuzzy completion (if on, turns on syntastic too)
" if off, turns on supertab
let g:vimrc_bundle_ycm=0
" syntax checking
let g:vimrc_bundle_syntastic=1
" CTRL-P replaces bufexplorer
let g:vimrc_bundle_ctrlp=1
" work/windows plugins
let g:vimrc_bundle_windows_dev=0
" in-file movement plugins
let g:vimrc_enhance_movement=1
" vim feature enhancements
let g:vimrc_feature_enhancements=1
" extra undo functionality
let g:vimrc_bundle_undo=0

if has("win32") || has("win64")
    " ==== Windows Configuration goes here ==== "

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &term =~ "xterm"
    set term=xterm-256color
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <M-5> <C-R>=expand('%:p:h')<CR>/
cnoremap <M-2> expand('%:p')
inoremap <C-t> <C-R>=strftime("TODO:vrj %Y.%m.%d: ")<CR>

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

"----------------------------------------------------------"
" Look And Feel
" Colors, Fonts, Syntax, Statuslines, etc
"----------------------------------------------------------"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lines
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>fn :set nu!<CR> :set rnu!<CR>
nnoremap <silent> <Leader>fN :set nornu<CR> :set nu!<CR>
"set nu
"set rnu
set so=2
" Line Breaks
setlocal lbr
"set textwidth=110
let &showbreak = '+++'  " Show line breaks using given symbol

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
nnoremap <silent> <Leader>hS :if exists("syntax_on") <Bar>
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

map <M-,> :call MoveToPrevTab()<CR>
map <M-.> :call MoveToNextTab()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
set splitright

map <M-Up> :copen<CR>
map <M-Down> :cclose<CR>
map <M-Left> :colder<CR>
map <M-Right> :cnewer<CR>

map <M-S-Up> :lopen<CR>
map <M-S-Down> :lclose<CR>
map <M-S-Left> :lolder<CR>
map <M-S-Right> :lnewer<CR>

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
" Scrollbars
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions=eg
nnoremap <Leader>xT :set guioptions+=T<CR>
nnoremap <Leader>xt :set guioptions-=T<CR>

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
" case sensitive/insensitive searches
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>fi :set ic! <CR>:set ic?<CR>
cnoremap <M-4> \>
cnoremap <M-6> \<



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>hs :set hlsearch!<CR>:set hlsearch?<CR>
nnoremap <Leader>hc :set cursorline! cursorcolumn!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jumping (with menus)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoremap <Leader>* :call <SID>JumpOccurrence()<CR>
" nnoremap <Leader>? :call <SID>JumpPrompt()<CR>

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
" nnoremap <Leader>/ /<C-R>=<SID>ScopeSearch('[[', 0)<CR>
" vnoremap <Leader>/ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>

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
" map <silent> <F11> :let fname = expand('%:p:h') . '/types.vim'<CR><F12>
" Just highlight tags based on existing tags.vim file.
":map <F12>  :so tags.vim<CR>
" map <silent> <F12> :if filereadable(fname)<Bar>
"     \   exe 'so ' . fname<CR>
"     \ endif <CR>



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
nnoremap <M-0> 0
nnoremap 0 ^
nnoremap ^ 0
nnoremap g0 g^
nnoremap g^ g0
" Remap home/end keys to act like windows text editors when lines wrap
nnoremap <Home> g0
nnoremap <End> g$
" ensure backspace works like expected on tabs
set backspace=indent,eol,start

nmap <silent> gb `[v`]


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
" changing directory
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>cd :lcd %:p:h<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copying tweaks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>ac ggvG$"+y''
vnoremap <Leader><C-y> "+y
nnoremap <Leader><C-v> "+p

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
Plugin 'gmarik/vundle'

if g:vimrc_enhance_movement == 1
    " in-file movement enhancements
    Plugin 'EasyMotion'                 " Easier movement
    Plugin 'tpope/vim-rsi'              " readline in insert mode
    Plugin 'vim-scripts/matchit.zip'

    Plugin 'terryma/vim-multiple-cursors'
    let g:multi_cursor_next_key='<M-n>'
    let g:multi_cursor_prev_key='<M-S-n>'
    let g:multi_cursor_skip_key='<M-m>'
    let g:multi_cursor_quit_key='<Esc>'
    let g:multi_cursor_exit_from_visual_mode = 0
    let g:multi_cursor_exit_from_insert_mode = 0
endif


if g:vimrc_feature_enhancements == 1
    " Vim feature enhancement
    Plugin 'mileszs/ack.vim'            " Better vimgrep
    Plugin 'rking/ag.vim'               " Better ack
    Plugin 'tpope/vim-dispatch'         " Better :make
    Plugin 'tpope/vim-obsession'        " Better :mksession
    " Extra undo support
    if g:vimrc_bundle_undo == 1
        " Undo extensions
        Plugin 'mbbill/undotree'
        noremap U :UndotreeToggle<CR>
        set undodir='/home/vernon/.vim/undo/'
        set undofile
    elseif g:vimrc_bundle_ctrlp == 1
        noremap U :CtrlPUndo<CR>
    endif
endif

" Editing enhancements
Plugin 'tpope/vim-surround'         " Surrounding movements
Plugin 'wellle/targets.vim'         " Many more movements
Plugin 'tpope/vim-repeat'
Plugin 'tComment'                   " better commenting

" Syntax enhancements
Plugin 'elzr/vim-json'              " json syntax highlighting
let g:vim_json_syntax_conceal = 0


" Colorscheme / Look-and-feel enhancements
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


" git integration
Plugin 'tpope/vim-fugitive'


" File/Dir movement enhancements
Plugin 'scrooloose/nerdtree'
nmap <silent> <F6> :NERDTreeToggle<CR>
nmap <silent> <C-F6> :NERDTreeFind<CR>
let NERDTreeDirArrows=0
let NERDTreeIgnore=['\.vim$', '\~$', '\.o', '\.gch', '\.am', '\.in']
" Ctrl-p extension
Plugin 'kien/ctrlp.vim'
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
    let g:ctrlp_max_files = 0
    let g:ctrlp_lazy_update = 1
    let g:ctrlp_root_markers = ['build']
endif
Plugin 'szw/vim-ctrlspace'
" Compilation
set wildignore+=*.dll,*.lib,*.pdb,*.org,*.tlb,*.obj,*.lnk,*.msi,*.exe
set wildignore+=*.pyo,*.pyc,*.so,*.o
" Pictures
set wildignore+=*.bmp,*.ico,*.svg,*.png,*.gif
" Archives
set wildignore+=*.zip,*.rar,*.tar,*.jar,*.tar.gz,*.tar.xz,*.tar.bz,*.7z
" Other
set wildignore+=*.chm,*.ilk,*.dfl,*.ttf
set wildignore+=*.iqw,*.ibn,*.wv,*.vam,*.suo
set wildignore+=*.doc,*.docx,*.xls,*.xlsx

if g:vimrc_bundle_ctrlp == 1
    nnoremap <leader>be :CtrlPBuffer<CR>
else
    " Buffer explorer
    Plugin 'bufexplorer.zip'
endif


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
    Plugin 'agassiyzh/Mark--Karkat'
    let g:mvDefaultHighlightingPalette = 'extended'
    set ssop+=globals
    nmap <k0> <Plug>MarkSearchAnyNext
    nmap <C-k0> <Plug>MarkSearchAnyPrev
endif

if g:vimrc_bundle_lisp == 1
    " Load bundles related to LISP coding
    Plugin 'guns/paredit'
    Plugin 'tpope/vim-fireplace'
    Plugin 'tpope/vim-classpath'
    Plugin 'guns/vim-clojure-static'
    Plugin 'kien/rainbow_parentheses.vim'
endif

if g:vimrc_bundle_airline == 1
    " Add heavier statusbar
    Plugin 'bling/vim-airline'
    " let g:airline#extensions#tabline#enabled = 1
    " let g:airline#extensions#tabline#show_buffers = 0
    " let g:airline#extensions#tabline#show_tab_type = 0
    " let g:airline#extensions#tabline#tab_nr_type = 1
    " let g:airline#extensions#tabline#tab_min_count = 2
endif


" Syntax Checking/Completion

if g:vimrc_bundle_ycm == 1
    " use heavier YCM for completion
    Plugin 'Valloric/YouCompleteMe'
    let g:ycm_key_invoke_completion = '<C-y>'
    let g:ycm_confirm_extra_conf = 0
    "let g:ycm_filetype_blacklist = { 'python': 1}
    let g:ycm_autoclose_preview_window_after_insertion = 1
    " use syntastic too
    let g:vimrc_bundle_syntastic=1
else
    " use lighter supertab for completion
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
    " Wiki extensions
    Plugin 'vim-scripts/wikipedia.vim'
    " I add this to the syntax file, right above sy include @TeX
    "let g:tex_isk="@,48-57,_,192-255"
    Plugin 'PProvost/vim-ps1'
endif




"----------------------------------------------------------"
" Helper Functions
"----------------------------------------------------------"
function! KillComments()
   " remove all c-style comments
   %s/\/\*\(.\|\n\)\{-}\*\/ \{0,}\n//g
   %s/\/\*\(.\|\n\)\{-}\*\///g
   %s/^ \+\/\/.*\n//g
   %s/\/\/.*//g
   %s/ \+$//g
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only use these commands when compiled with support for autocommands
if has("autocmd")
    filetype plugin indent on
    "set grepprg=grep\ -nH\ $*
    "let g:tex_flavor = "latex"

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

    " load the types.vim highlighting file, if it exists
    " autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
    " autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
    " autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
    " autocmd BufRead,BufNewFile *.[ch] endif

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Movement Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

