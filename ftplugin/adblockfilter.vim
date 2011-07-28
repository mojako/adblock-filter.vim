" ============================================================================
" Language:     Adblock-Filter
" File:         ftplugin/adblockfilter.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/adblock-filter.vim
" Last Change:  2011-07-24
" ============================================================================

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

setlocal comments=:! commentstring=!%s
setlocal formatoptions-=t formatoptions+=croql

" vim: set et sts=4 sw=4 wrap:
