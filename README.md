# Requirements

- Install [ale](https://github.com/w0rp/ale)

# Install

Install via [vim-plug](https://hiberabyss.github.io/2018/03/21/vim-plug-introduction/):

```vim
Plug 'https://github.com/hiberabyss/spa-lint'
```


# Configuration

Add following lines into your `.vimrc`

```vim
let g:tencent_linters_dir = expand('path/to/your/code/trunk/app/qzap/common/tool')

let g:ale_linters.cpp = ['cpplintx']
let g:ale_linters.sh = ['shlint']
let g:ale_linters.python = ['pylintx']
```

