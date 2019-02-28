" Copyright (c) 2018, Tencent Inc
" Author: Hongbo Liu <hongboliu@tencent.com>
" Date  : 2018-10-01 20:44:42

call ale#Set('ccnlint_options', '')

function! handlers#ccnlinter#GetCommand(buffer)
    let l:options = ale#Var(a:buffer, 'ccnlint_options')

    return ale#path#BufferCdString(a:buffer) 
                \ . ' %e' . ale#Pad(l:options) . ' '
                \ . fnamemodify(bufname(a:buffer), ':p:t')
endfunction

function! handlers#ccnlinter#HandleFormat(buffer, lines)
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

function! handlers#ccnlinter#AddLinter(filetype)
  call ale#linter#Define(a:filetype, {
        \   'name': 'ccnlint',
        \   'output_stream': 'both',
        \   'executable': 'ccnlint_diff.py',
        \   'command': function('handlers#ccnlinter#GetCommand'),
        \   'callback': 'handlers#ccnlinter#HandleFormat',
        \   'lint_file': 1,
        \})
endfunction
