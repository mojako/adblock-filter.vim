" ============================================================================
" Language:     Adblock-Filter
" File:         ftplugin/adblockfilter.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/adblock-filter.vim
" Last Change:  2011-09-02
" ============================================================================

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

setlocal comments=:! commentstring=!%s

augroup AdblockFilter
au BufWritePre <buffer> if &modified && &ft ==# 'adblockfilter'
  \ && exists('g:adblock_filter_auto_checksum')
  \ && g:adblock_filter_auto_checksum |
  \     call adblockfilter#rewrite_checksum() |
  \ endif
augroup END

let b:undo_ftplugin='setlocal com< cms< | au! AdblockFilter * <buffer>'

" vim: set et sts=4 sw=4 wrap:
