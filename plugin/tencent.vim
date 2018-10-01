if !exists('g:spa_code_dir')
  let g:spa_code_dir = expand('$HOME/Tencent/qzone_adsdev_proj/trunk')
endif

if !exists('g:spa_simian_path')
  let g:spa_simian_path = g:spa_code_dir . '/thirdparty/simian-2.5.10/bin/simian-2.5.10.jar'
endif

let s:lint_dir = g:spa_code_dir . "/app/qzap/common/tool"
if $PATH !~ s:lint_dir
  let $PATH = $PATH .':'. s:lint_dir
endif
