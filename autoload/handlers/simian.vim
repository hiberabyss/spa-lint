function! handlers#simian#GetCommand(buffer)
    let l:options = ale#Var(a:buffer, 'simian_options')

    return ale#path#BufferCdString(a:buffer) 
                \ . ' %e -jar ' .g:spa_simian_path. ' ' . ale#Pad(l:options) . ' '
                \ . fnamemodify(bufname(a:buffer), ':p:t')
endfunction

function! handlers#simian#HandleFormat(buffer, lines)
    " Look for lines like the following.
    "  Between lines 196 and 232 in increment_doc_builder.cc
    let l:pattern = '\v (Between lines (\d+) .+) in'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
      call add(l:output, {
            \   'lnum': l:match[2] + 0,
            \   'col': 0,
            \   'text': 'Simian: '. l:match[1],
            \   'type': 'E',
            \})
    endfor

    return l:output
endfunction

function! handlers#simian#AddLinter(filetype)
  call ale#Set('simian_executable', 'java')
  call ale#Set('simian_options', '')


  call ale#linter#Define(a:filetype, {
        \   'name': 'simian',
        \   'output_stream': 'both',
        \   'executable_callback': ale#VarFunc('simian_executable'),
        \   'command_callback': 'handlers#simian#GetCommand',
        \   'callback': 'handlers#simian#HandleFormat',
        \   'lint_file': 1,
        \})
endfunction
