" ============================================================================
" File:         plugin/adblockfilter.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/adblock-filter.vim
" Last Change:  2011-08-06
" ============================================================================

" s:cpo_save {{{1
let s:cpo_save = &cpo
set cpo&vim
"}}}

augroup AdblockFilter
    au!
    au BufWritePre *.txt call s:auto_rewrite_checksum()
augroup END

function! s:auto_rewrite_checksum()
    if !&modified || &ft != 'adblockfilter'
        return
    endif

    if exists('g:adblock_filter_auto_checksum')
      \ && g:adblock_filter_auto_checksum
        call adblockfilter#rewrite_checksum()
    endif
endfunction

" s:cpo_save {{{1
let &cpo = s:cpo_save
unlet s:cpo_save
"}}}

" vim: set et sts=4 sw=4 wrap:
