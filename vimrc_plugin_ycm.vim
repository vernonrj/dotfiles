" YouCompleteMe configuration

Plugin 'Valloric/YouCompleteMe'
augroup vimrcYcm
    autocmd!
    autocmd BufReadPost *
                \ if getfsize(expand('%')) > (g:ycm_disable_for_files_larger_than_kb * 1024) |
                \   imap <buffer> <Tab> <Plug>SuperTabForward|
                \   imap <buffer> <S-Tab> <Plug>SuperTabBackward|
                \ endif
    autocmd BufReadPost *.rs :nmap <silent> <buffer> <nowait> <C-]> :YcmCompleter GoTo<CR>
augroup END
let g:ycm_key_invoke_completion = '<C-y>'
let g:ycm_confirm_extra_conf = 0
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ 'log' : 1
      \}

function! VimrcUseSupertab()
    setlocal completefunc=
    imap <buffer> <Tab> <Plug>SuperTabForward
    imap <buffer> <S-Tab> <Plug>SuperTabBackward
endfunction

