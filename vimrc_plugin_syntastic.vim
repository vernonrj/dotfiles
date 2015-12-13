" Add syntax checking
Plugin 'scrooloose/syntastic'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_cpp_checkers = ['cppcheck', 'gcc']
if !exists('g:syntastic_mode_map')
    let g:syntastic_mode_map = {"mode": "active",
                \ "active_filetypes": ["python"],
                \ "passive_filetypes": []}
endif
nnoremap <F5> :SyntasticCheck<CR>
nnoremap <C-F5> :SyntasticToggleMode<CR>
nnoremap <C-S-F5> :SyntasticReset<CR>
if g:vimrc_rsa_1es == 1
    let g:syntastic_mode_map["passive_filetypes"] += ["cpp"]
endif

