" Command-T
" faster than ctrl-p, but more difficult to set up
Plugin 'wincent/command-t'

let g:CommandTMaxCachedDirectories = 5
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxHeight = 20

if exists('vimrc_rsa_1es') && vimrc_rsa_1es == 1
    let g:CommandTMaxFiles = 1000000
    let g:CommandTSCMDirectories = '.git,.hg,.svn,.bzr,_darcs,build'
endif

nnoremap <silent> <C-p> :CommandT<CR>
nnoremap <silent> <M-p> :CommandT .<CR>

if executable('watchman')
    let g:CommandTFileScanner = 'watchman'
endif

