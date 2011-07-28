" ============================================================================
" Language:     Adblock-Filter
" File:         ftdetect/adblockfilter.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/adblock-filter.vim
" Last Change:  2011-07-24
" ============================================================================

au! BufNewFile,BufRead *.txt call s:detect_adblock_filter()
function! s:detect_adblock_filter()
    if getline(1) =~ '\[Adblock.*\]'
        setfiletype adblockfilter
    endif
endfunction

" vim: set et sts=4 sw=4 wrap:
