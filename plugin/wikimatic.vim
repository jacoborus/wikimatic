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
command! -nargs=0 CreateMarkdownLink call CreateMarkdownLink()

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
    vnoremap <buffer> <enter> :call CreateMarkdownLink()<cr>
  endif
endfunction

function! CreateMarkdownLink()
  " Replace the selected text with the Markdown link
  let selection = getline('v')
  let result = substitute(selection, '\v^', '[&](#)', 'g')
  echo result
  call setline('v', result)
  " Move the cursor to the end of the selected text
  let cursor_col = col('.')
  let link_end = cursor_col + len(result)
  call cursor(line('.'), link_end)
endfunction
