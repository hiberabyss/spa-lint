" Author            : Hongbo Liu <hongboliu@tencent.com>
" Date              : 2018-09-06

call ale#Set('cpp_cpplintx_executable', 'cpplintx.py')
call ale#Set('cpp_cpplintx_options', '')

function! ale_linters#cpp#cpplintx#GetCommand(buffer) abort
    let l:options = ale#Var(a:buffer, 'cpp_cpplintx_options')

    return ale#path#BufferCdString(a:buffer) 
                \ . ' %e' . ale#Pad(l:options) . ' '
                \ . fnamemodify(bufname(a:buffer), ':p:t')
endfunction

function! ale_linters#cpp#cpplintx#HandleCppLintxFormat(buffer, lines) abort
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

call ale#linter#Define('cpp', {
\   'name': 'cpplintx',
\   'output_stream': 'both',
\   'executable_callback': ale#VarFunc('cpp_cpplintx_executable'),
\   'command_callback': 'ale_linters#cpp#cpplintx#GetCommand',
\   'callback': 'ale_linters#cpp#cpplintx#HandleCppLintxFormat',
\   'lint_file': 1,
\})
