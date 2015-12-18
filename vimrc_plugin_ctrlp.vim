" Ctrlp
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
nnoremap <C-Space> :CtrlPBuffer<CR>
let g:ctrlp_max_files = 0
let g:ctrlp_lazy_update = 1
if has('python')
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
