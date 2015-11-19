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
