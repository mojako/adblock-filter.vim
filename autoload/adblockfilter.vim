" ============================================================================
" File:         autoload/adblockfilter.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/adblock-filter.vim
" Last Change:  2011-08-06
" ============================================================================

" s:cpo_save {{{1
let s:cpo_save = &cpo
set cpo&vim
"}}}

" adblockfilter#get_checksum() {{{1
" ============================
function! adblockfilter#get_checksum()
    if executable('openssl')
        let cmd = 'openssl dgst -md5 -binary | openssl enc -base64'
    else
        return ''
    endif

    let data = join(filter(getline(1, '$'),
      \ 'v:val !~ "^!\\c\\s\*checksum[ :-]\\+"'), "\n") . "\n"

    if &enc != 'utf-8'
        let data = iconv(data, &enc, 'utf-8')
    endif

    let data = substitute(data, '\r', '', 'g')
    let data = substitute(data, '\n\{2,}', '\n', 'g')

    let checksum = system(cmd, data)

    return substitute(checksum, '[\s\n=]*$', '', '')
endfunction

" adblockfilter#rewrite_checksum() {{{1
" ================================
function! adblockfilter#rewrite_checksum()
    let pat = '^\c\s*!\s*checksum[ :-]\+\zs[A-Za-z0-9\+\/=]*'
    let i = 1
    while i <= line('$')
        let line = getline(i)
        if line =~ pat
            if !exists('checksum')
                let checksum = adblockfilter#get_checksum()
                if checksum == ''
                    echohl WarningMsg
                    redraw | echomsg "checksum function requires 'openssl'"
                    echohl None
                endif
            endif

            let rep = substitute(line, pat, checksum, '')
            if line !=# rep
                call setline(i, rep)
            endif
        endif
        let i = i + 1
    endwhile
endfunction
"}}}

" s:cpo_save {{{1
let &cpo = s:cpo_save
unlet s:cpo_save
"}}}
"
" vim: set et sts=4 sw=4 wrap:
