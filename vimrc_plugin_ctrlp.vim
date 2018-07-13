" Ctrlp
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
if executable('rg')
    let g:ctrlp_user_command = "rg --files %s"
endif
nnoremap <C-Space> :CtrlPBuffer<CR>
let g:ctrlp_max_files = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_switch_buffer = 'e'
if has('python')
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
if has('win32')
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    call extend(g:airline_symbols, {
                \ 'linenr': ':',
                \ 'paste': 'PASTE',
                \ 'maxlinenr': '',
                \ 'notexists': '∄',
                \ 'readonly': 'RO',
                \ 'spell': 'SPELL',
                \ 'modified': '+',
                \ 'space': ' ',
                \ 'crypt': '🔒',
                \ 'branch': '',
                \ 'whitespace': '!'
                \ }, 'keep')
endif
