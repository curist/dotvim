let g:neocomplcache_enable_at_startup = 1

" use neocomplcache & clang_complete
" add neocomplcache option
let g:neocomplcache_force_overwrite_completefunc = 1

" add clang_complete option
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.c =
            \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objcpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
