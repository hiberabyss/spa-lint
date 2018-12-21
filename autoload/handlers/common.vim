" Copyright (c) 2018, Tencent Inc
" Author: Hongbo Liu <hongboliu@tencent.com>
" Date  : 2018-12-21 16:02:33

function! handlers#common#GetCommand(buffer)
    let l:options = ale#Var(a:buffer, 'common_options')

    return ale#path#BufferCdString(a:buffer) 
                \ . ' %e' . ale#Pad(l:options) . ' '
                \ . fnamemodify(bufname(a:buffer), ':p:t')
endfunction

function! handlers#common#HandleFormat(buffer, lines)
  let l:pattern = '\f\{-}:\(\d\+\):[ \t]\+\(.\+\)'
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

function! handlers#common#AddLinter(filetype, command, name)
  call ale#Set('common_executable', a:command)
  call ale#Set('common_options', '')

  call ale#linter#Define(a:filetype, {
        \   'name': a:name,
        \   'output_stream': 'both',
        \   'executable_callback': ale#VarFunc('common_executable'),
        \   'command_callback': 'handlers#common#GetCommand',
        \   'callback': 'handlers#common#HandleFormat',
        \   'lint_file': 1,
        \})
endfunction
