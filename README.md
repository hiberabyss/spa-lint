# Requirements

- Install [ale](https://github.com/w0rp/ale)
- Install checkstyle for java: `brew install checkstyle`

# Install

Install via [vim-plug](https://hiberabyss.github.io/2018/03/21/vim-plug-introduction/):

```vim
Plug 'https://github.com/hiberabyss/spa-lint'
```


# Configuration

Add following lines into your `.vimrc`

```vim
let g:spa_code_dir = expand('path/to/your/code/trunk')

let g:ale_linters = {
			\ 'cpp': ['cpplint', 'cpplintx', 'ccnlint', 'simian'],
      \ 'java' : ['checkstyle'],
      \ 'sh' : ['shlint'],
      \ 'python' : ['pylintx'],
			\ }
```
