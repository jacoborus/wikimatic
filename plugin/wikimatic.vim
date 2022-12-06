" Title:        Wikimatic
" Description:  The simplest wiki vim can get you
" Last Change:  6 December 2022
" Maintainer:   Jacobo Tabernero Rey <https://github.com/jacoborus>

if exists("g:loaded_wikimatic")
    finish
endif

if !exists("g:wikimatic_path")
    echo 'missing wiki path'
    finish
endif

let g:loaded_wikimatic = 1

command! -nargs=0 WikiLink call wikimatic#IsMdLink()
command! -nargs=0 WikiNextLink call wikimatic#JumpToNextMarkdownLink()
command! -nargs=0 WikiPrevLink call wikimatic#JumpToPreviousMarkdownLink()

augroup wikigroup
  autocmd!
  autocmd FileType markdown call MapLinks()
augroup end

function! MapLinks ()
  if expand('%:p') =~# expand(g:wikimatic_path)
    map <buffer> <enter> :WikiLink<cr>
    map <buffer> gf :WikiLink<cr>
    map <buffer> <tab> :WikiNextLink<cr>
    map <buffer> <S-tab> :WikiPrevLink<cr>
  endif
endfunction
