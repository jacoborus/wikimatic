function! wikimatic#OpenWiki()
  let path = g:wikimatic_path
  execute "e ".path."/index.md"
endfunction

function! wikimatic#OpenWikiTab()
  let path = g:wikimatic_path
  execute "tabe ".path."/index.md"
endfunction

function! wikimatic#GoOrCreate()
  let line = getline('.')
  let cursor_col = col('.')
  let link_regex = '\[.*\]\(.*\)'
  let line_length = strlen(line)
  if cursor_col <= line_length
    let possible_link = line[0:line_length]
    let link_start = match(possible_link, link_regex)
    if link_start >= 0
      let link_end = link_start + strlen(matchstr(possible_link, link_regex))
      if cursor_col >= link_start && cursor_col <= link_end
        call wikimatic#NavigateToMarkdownLink()
        return 1
      endif
    endif
  endif
  call wikimatic#CreateLinkFromCursor()
  return 0
endfunction

function! wikimatic#CreateLinkFromCursor()
  let word = expand("<cword>")
  let link = printf("[%s](%s.md)", word, tolower(word))
  normal! diw
  execute "normal! a" . link
endfunction

function! wikimatic#CreateLinkFromVisual()
  try
    let a_save = @a
    execute 'normal! gv"as'
    let saved_sel = @a
    let sel_text = substitute(saved_sel, ' ', '_', 'g')
    let link_text = "[".saved_sel."](".tolower(sel_text).".md)"
    if col('.') == 1
      execute "normal i".link_text
    else
      execute "normal a".link_text
    endif
  finally
    let @a = a_save
  endtry
endfunction

" NAVIGATION
function! wikimatic#JumpToNextMarkdownLink()
  let link_regex = '\[.*\]\((.*)\)'
  let next_link_pos = search(link_regex, 'w')
  if next_link_pos != 0
    call cursor(next_link_pos, 0)
  else
    echohl ErrorMsg | echo "No more Markdown links found!" | echohl None
  endif
endfunction

function! wikimatic#JumpToPreviousMarkdownLink()
  let link_regex = '\[.*\]\((.*)\)'
  let prev_link_pos = search(link_regex, 'b')
  if prev_link_pos != 0
    call cursor(prev_link_pos, 0)
  else
    echohl ErrorMsg | echo "No more Markdown links found!" | echohl None
  endif
endfunction

function! wikimatic#NavigateToMarkdownLink()
  let line = getline('.')
  let cursor_col = col('.')
  let link_regex = '\[.*\]\((.*)\)'
  let url_regex = '\v^((https?|ftp|file)://)|(www\.).+'
  if cursor_col <= strlen(line)
    let possible_link = line[0:strlen(line)]
    let link_start = match(possible_link, link_regex)
    if link_start >= 0
      let link_end = link_start + strlen(matchstr(possible_link, link_regex))
      if cursor_col >= link_start && cursor_col <= link_end
        let link = matchstr(possible_link, link_regex)
        let link_target = substitute(link, link_regex, '\1', '')
        let clean_link = link_target[1:strlen(link_target) -2]
        if match(clean_link, url_regex) >= 0
          silent execute ":!xdg-open " . clean_link
        else
          let current_file_dir = expand("%:h")
          let clean_link_file = fnameescape(current_file_dir . '/' . clean_link)
          execute 'e ' . clean_link_file
        endif
      endif
    endif
  endif
endfunction

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
