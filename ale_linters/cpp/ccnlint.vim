" Author            : Hongbo Liu <hongboliu@tencent.com>
" Date              : 2018-09-06
" Last Modified Date: 2018-09-06
" Last Modified By  : Hongbo Liu <hongboliu@tencent.com>

call ale#Set('ccnlint_executable', 'ccnlint_diff.py')
call ale#Set('ccnlint_options', '')

function! ale_linters#cpp#ccnlint#GetCommand(buffer)
    let l:options = ale#Var(a:buffer, 'ccnlint_options')

    return ale#path#BufferCdString(a:buffer) 
                \ . ' %e' . ale#Pad(l:options) . ' '
                \ . fnamemodify(bufname(a:buffer), ':p:t')
endfunction

function! ale_linters#cpp#ccnlint#HandleccnlintFormat(buffer, lines)
    " Look for lines like the following.
    " parse_recordio.cc:17: pointer: Suggest keeping same style in one file, using
    let l:pattern = '^.\+;\(\d\+\).\{-}: \(.\+(line \(\d\+\)).\{-}\d\+\)'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
      let pretext = ''
      if l:match[1] == '33'
        let pretext = "OLD: "
      else
        let pretext = "NEW: "
      endif

      call add(l:output, {
            \   'lnum': l:match[3] + 0,
            \   'col': 0,
            \   'text': pretext. l:match[2],
            \   'type': 'E',
            \})
    endfor

    return l:output
endfunction

call ale#linter#Define('cpp', {
\   'name': 'ccnlint',
\   'output_stream': 'both',
\   'executable_callback': ale#VarFunc('ccnlint_executable'),
\   'command_callback': 'ale_linters#cpp#ccnlint#GetCommand',
\   'callback': 'ale_linters#cpp#ccnlint#HandleccnlintFormat',
\   'lint_file': 1,
\})
