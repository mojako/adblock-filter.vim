" ============================================================================
" Language:     Adblock-Filter
" File:         syntax/adblockfilter.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/adblock-filter.vim
" Last Change:  2011-07-24
" ============================================================================

" s:cpo_save {{{1
let s:cpo_save = &cpo
set cpo&vim
"}}}

if version < 600
    syntax clear
elseif exists('b:current_syntax')
    finish
endif

syn case ignore
syn match   adblockFilterHeader         '^\[Adblock.*\]\n'

" Basic rule {{{1
" ==========
syn match   adblockFilterBasicRule      '^[^#\$]*\%(\$.*\)$'
  \ contains=adblockFilterUrl,adblockFilterOptions

syn match   adblockFilterUrl            '^[^#\$]\+'
  \ contains=adblockFilterDomain,adblockFilterException,
  \          adblockFilterRegularExpressions,
  \          adblockFilterWildcardChar,adblockFilterSeparatorChar

syn match   adblockFilterDomain         '^|https\?://[A-Za-z0-9\.\*-]\+'
  \ contained contains=adblockFilterWildcardChar
syn match   adblockFilterDomain         '^||[A-Za-z0-9\.\*-]\+'
  \ contained contains=adblockFilterWildcardChar

syn match   adblockFilterException      '^@@[^#\$]*' contained

syn match   adblockFilterTooShortRule
   \ '^\%(@@\)\?[A-Za-z0-9%]*\%([^A-Za-z0-9%][A-Za-z0-9%]\{,2}\)*[A-Za-z0-9%]*\%(\$.*\)\?$'

" Regular expressions {{{2
" -------------------
syn match   adblockFilterRegularExpressions
  \ '^/\%([^/]\|\\/\)\+/\ze\%(\$\|$\)' contained

" Options {{{2
" -------
syn match   adblockFilterOptions        '\$.\+$'
  \ contains=adblockFilterOptDomains

syn match   adblockFilterOptDomains     'domain=\zs[^,]\+'
  \ contained contains=adblockFilterExceptionDomain

" Element hiding {{{1
" ==============
syn match   adblockFilterElementHiding  '^[A-Za-z0-9 ,\~\.-]*##.\+$'
  \ contains=adblockFilterDomains,adblockFilterCSSSelector

syn match   adblockFilterDomains        '^[A-Za-z0-9 ,\~\.-]*\ze#'
  \ contained contains=adblockFilterExceptionDomain
syn match   adblockFilterExceptionDomain    '\~[A-Za-z0-9\.-]\+' contained

syn match   adblockFilterCSSSelector    '##\@<=.\+$' contained
  \ contains=adblockFilterIdSelector,adblockFilterClassSelector,
  \          adblockFilterAttributeSelector,adblockFilterCombinationSelector,
  \          adblockFilterWildcardChar
syn match   adblockFilterIdSelector     '#[A-Za-z_@][A-Za-z0-9_@-]*' contained
syn match   adblockFilterClassSelector  '\.[A-Za-z_@][A-Za-z0-9_@-]*' contained
syn region  adblockFilterAttributeSelector oneline start='\[' end=']'
  \ contained contains=adblockFilterStringQuoted,adblockFilterStringDoubleQuoted
syn match   adblockFilterCombinationSelector    '[>+\~]' contained

" Simplified element hiding (is deprecated) {{{2
" -----------------------------------------
syn match   adblockFilterSimplifiedElementHiding    '^[^#]*#\%\(#\)\@!.*'
  \ contains=adblockFilterDomains,adblockFilterSimplifiedSelector

syn match   adblockFilterSimplifiedSelector         '#\@<=.\+$'
  \ contained contains=adblockFilterSimplifiedIdSelector
syn region  adblockFilterSimplifiedIdSelector oneline
  \ start='(\zs.' end='.\ze)' contained
  \ contains=adblockFilterStringQuoted,adblockFilterStringDoubleQuoted

" Special Char {{{1
" ============
syn match   adblockFilterEscapedDoubleQuote '\\"' contained
syn region  adblockFilterStringQuoted oneline
  \ start='"'rs=s+1 skip='\\\\\|\\"' end='"'re=e-1
  \ contained contains=adblockFilterEscapedDoubleQuote
syn match   adblockFilterEscapedQuote "\\'" contained
syn region  adblockFilterStringQuoted oneline
  \ start="'"rs=s+1 skip="\\\\\|\\'" end="'"re=e-1
  \ contained contains=adblockFilterEscapedQuote

syn match   adblockFilterWildcardChar   '\*'
syn match   adblockFilterSeparatorChar  '\^'

" Comments {{{1
" ========
syn match   adblockFilterComment        '^!.*$'
  \ contains=adblockFilterCommentTitle,@Spell
syn match   adblockFilterCommentTitle
  \ '\u[A-Za-z0-9-]\+\%( \u[A-Za-z0-9-]\+\)*:' contained
"}}}

" Highlight Group Link {{{1
" ====================
if v:version >= 508 || !exists('did_adblock_filter_syn_inits')
    if v:version < 508
        let did_adblock_filter_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink  adblockFilterHeader                     Comment
    HiLink  adblockFilterComment                    Comment
    HiLink  adblockFilterCommentTitle               PreProc

    HiLink  adblockFilterDomain                     Type

    HiLink  adblockFilterException                  Exception
    HiLink  adblockFilterTooShortRule               Error

    HiLink  adblockFilterRegularExpressions         Identifier

    HiLink  adblockFilterOptions                    Constant
    HiLink  adblockFilterOptDomains                 Type

    HiLink  adblockFilterElementHiding              Constant
    HiLink  adblockFilterSimplifiedElementHiding    Constant

    HiLink  adblockFilterDomains                    Type
    HiLink  adblockFilterExceptionDomain            Exception

    HiLink  adblockFilterCSSSelector                Constant
    HiLink  adblockFilterSimplifiedSelector         Constant
    HiLink  adblockFilterIdSelector                 Identifier
    HiLink  adblockFilterSimplifiedIdSelector       Identifier
    HiLink  adblockFilterClassSelector              Identifier
    HiLink  adblockFilterAttributeSelector          Identifier
    HiLink  adblockFilterCombinationSelector        Normal

    HiLink  adblockFilterStringDoubleQuoted         String
    HiLink  adblockFilterStringQuoted               String
    HiLink  adblockFilterWildcardChar               SpecialChar
    HiLink  adblockFilterSeparatorChar              SpecialKey

    delcommand HiLink
endif
"}}}

let b:current_syntax = 'adblock-filter'

" s:cpo_save {{{1
let &cpo = s:cpo_save
unlet s:cpo_save
"}}}

" vim: set et sts=4 sw=4 wrap:
