if !exists('g:vimrc_sourced_files')
    let g:vimrc_sourced_files = {}
endif
if has_key(g:vimrc_sourced_files, 'functions')
    finish
endif
let g:vimrc_sourced_files['functions'] = 1

let g:vimrc_warnings = []
function! WarnFnNotAvailable(compileopt, functionality)
    let g:vimrc_warnings += [
                \ 'vim not compiled with "'
                \ . a:compileopt
                \ . '" feature, lost functionality "'
                \ . a:functionality
                \ . '"'
                \]
endfunction

" Diff original file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis

" Search quickfix window
function! GrepQuickFix(pat)
  let all = getqflist()
  for d in all
    if bufname(d['bufnr']) !~ a:pat && d['text'] !~ a:pat
        call remove(all, index(all,d))
    endif
  endfor
  call setqflist(all)
endfunction
command! -nargs=* GrepQF call GrepQuickFix(<q-args>)

function! RemoveQuickFix(pat)
  let all = getqflist()
  for d in all
    if bufname(d['bufnr']) =~ a:pat || d['text'] =~ a:pat
        call remove(all, index(all,d))
    endif
  endfor
  call setqflist(all)
endfunction
command! -nargs=* RemoveQF call RemoveQuickFix(<q-args>)


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


" Cleartool functions
command! -nargs=0 -complete=command CTree exec 
    \ ":Start! clearvtree.exe ".expand("%")
command! -nargs=0 -complete=command CDiff exec
    \ ":Start! cleartool diff -graphical -pred \"".expand("%")."\""
command! -nargs=0 -complete=command CCheckout exec
    \ "!start cleartool checkout \"".expand("%")."\""
command! -nargs=0 -complete=command CCommit exec
    \ "!start cleartool checkin \"".expand("%")."\""
command! -nargs=0 -complete=command CUnco exec
    \ "!start cleartool uncheckout \"".expand("%")."\""

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


function! CtrlSpaceBufDo(command)
    for s:bufnumber in keys(ctrlspace#bufferlist(tabpagenr()))
        echo a:command
        execute(a:command)
        CtrlSpaceGoNext
    endfor
endfunction
command! -nargs=* CtrlSpaceBufDo call CtrlSpaceBufDo(<f-args>)

" vim:ft=vim:ts=4:sw=4:
