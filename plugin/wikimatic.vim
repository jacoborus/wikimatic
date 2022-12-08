" Title:        Wikimatic
" Description:  The simplest wiki vim can get you
" Maintainer:   Jacobo Tabernero Rey <https://github.com/jacoborus>

if exists("g:loaded_wikimatic")
    finish
endif

if !exists("g:wikimatic_path")
    echo 'missing wiki path'
    finish
endif

let g:loaded_wikimatic = 1

command! -nargs=0 Wiki call wikimatic#OpenWiki()
command! -nargs=0 WikiTab call wikimatic#OpenWikiTab()
command! -nargs=0 WikiGo call wikimatic#NavigateToMarkdownLink()
command! -nargs=0 WikiLink call wikimatic#GoOrCreate()
command! -nargs=0 WikiLinkVisual call wikimatic#CreateLinkFromVisual()
command! -nargs=0 WikiLinkCursor call wikimatic#CreateLinkFromCursor()
command! -nargs=0 WikiNextLink call wikimatic#JumpToNextMarkdownLink()
command! -nargs=0 WikiPrevLink call wikimatic#JumpToPreviousMarkdownLink()

augroup wikigroup
  autocmd!
  autocmd FileType markdown call MapLinks()
augroup end

function! MapLinks ()
  if expand('%:p') =~# expand(g:wikimatic_path)
    nnoremap <buffer> <enter> :WikiLink<cr>
    nnoremap <buffer> <tab> :WikiNextLink<cr>
    nnoremap <buffer> <S-tab> :WikiPrevLink<cr>
    vnoremap <buffer> <enter> :call wikimatic#CreateLinkFromVisual()<cr>
  endif
endfunction

