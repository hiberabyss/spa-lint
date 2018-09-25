" Author            : Hongbo Liu <hongboliu@tencent.com>
" Date              : 2018-09-07
" Last Modified Date: 2018-09-07
" Last Modified By  : Hongbo Liu <hongboliu@tencent.com>

call ale#Set('shlint_executable', 'shlint.py')
call ale#Set('shlint_options', '')

function! ale_linters#sh#shlint#GetCommand(buffer) abort
    let l:options = ale#Var(a:buffer, 'shlint_options')

    return ale#path#BufferCdString(a:buffer) 
                \ . ' %e' . ale#Pad(l:options) . ' '
                \ . fnamemodify(bufname(a:buffer), ':p:t')
endfunction

function! ale_linters#sh#shlint#HandleCppLintxFormat(buffer, lines) abort
    " Look for lines like the following.
    " test.cpp:5:  Estra space after ( in function call [whitespace/parents] [4]
    let l:pattern = '^.\{-}:\(\d\+\): \(.\+\)'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': l:match[1] + 0,
        \   'col': 0,
        \   'text': join(split(l:match[2])),
        \   'type': 'E',
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('sh', {
\   'name': 'shlint',
\   'output_stream': 'both',
\   'executable_callback': ale#VarFunc('shlint_executable'),
\   'command_callback': 'ale_linters#sh#shlint#GetCommand',
\   'callback': 'ale_linters#sh#shlint#HandleCppLintxFormat',
\})
