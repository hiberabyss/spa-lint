if !exists('g:spa_code_dir')
  let g:spa_code_dir = expand('$HOME/Tencent/qzone_adsdev_proj/trunk')
endif

if !exists('g:spa_simian_path')
  let g:spa_simian_path = g:spa_code_dir . '/thirdparty/simian-2.5.10/bin/simian-2.5.10.jar'
endif

let g:ale_cpp_cpplint_options = '--linelength=100'
let g:ale_java_checkstyle_options = printf('-c %s/thirdparty/java/checkstyle/google_checks.xml', g:spa_code_dir)

let s:lint_dir = g:spa_code_dir . '/app/qzap/common/tool'
if $PATH !~ s:lint_dir
  let $PATH = $PATH .':'. s:lint_dir
endif
