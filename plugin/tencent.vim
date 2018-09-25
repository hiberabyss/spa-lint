if !exists('g:tencent_linters_dir')
    let g:tencent_linters_dir = expand('$HOME/Tencent/qzone_adsdev_proj/trunk/app/qzap/common/tool')
endif

if $PATH !~ g:tencent_linters_dir
    let $PATH = $PATH .':'. g:tencent_linters_dir
endif
