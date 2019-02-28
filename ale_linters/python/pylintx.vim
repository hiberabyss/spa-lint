" Author            : Hongbo Liu <hongboliu@tencent.com>
" Date              : 2018-09-06
" Last Modified Date: 2018-09-06
" Last Modified By  : Hongbo Liu <hongboliu@tencent.com>

call ale#Set('py_pylintx_executable', 'pylintx.py')
call ale#Set('py_pylintx_options', '')

function! ale_linters#python#pylintx#GetCommand(buffer) abort
    let l:options = ale#Var(a:buffer, 'py_pylintx_options')

    return '%e' . ale#Pad(l:options) . ' %s'
endfunction

function! ale_linters#python#pylintx#HandlepyLintxFormat(buffer, lines) abort
    " Look for lines like the following.
    " parse_recordio.cc:17: pointer: Suggest keeping same style in one file, using
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

call ale#linter#Define('python', {
\   'name': 'pylintx',
\   'output_stream': 'both',
\   'executable': {b -> ale#Var(b, 'py_pylintx_executable')},
\   'command': function('ale_linters#python#pylintx#GetCommand'),
\   'callback': 'ale_linters#python#pylintx#HandlepyLintxFormat',
\   'lint_file': 1,
\})
