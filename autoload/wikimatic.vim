function! wikimatic#IsMdLink()
  let line = getline('.')
  let cursor_col = col('.')
  let link_regex = '\[.*\]\(.*\)'
  let line_length = strlen(line)
  if cursor_col < line_length
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
  call wikimatic#ConvertToMarkdownLink()
  return 0
endfunction

function! wikimatic#ConvertToMarkdownLink()
  " Get the word that was under the cursor
  let word = expand("<cword>")
  " Construct the Markdown link string
  let link = printf("[%s](%s.md)", word, word)
  " Enter normal mode and change the inner word
  normal! diw
  " Insert the Markdown link string at the cursor position
  execute "normal! a" . link
endfunction

function! wikimatic#NavigateToMarkdownLink()
  let line = getline('.')
  let cursor_col = col('.')
  let link_regex = '\[.*\]\((.*)\)'
  let url_regex = '\v^((https?|ftp|file)://)|(www\.).+'
  if cursor_col < strlen(line)
    let possible_link = line[0:strlen(line)]
    let link_start = match(possible_link, link_regex)
    if link_start >= 0
      let link_end = link_start + strlen(matchstr(possible_link, link_regex))
      if cursor_col >= link_start && cursor_col <= link_end
        let link = matchstr(possible_link, link_regex)
        let link_target = substitute(link, link_regex, '\1', '')
        let clean_link = link_target[1:strlen(link_target) -2]
        " Check if the clean_link is a valid URL
        if match(clean_link, url_regex) >= 0
          " Open the URL in the default web browser
          silent execute ":!xdg-open " . clean_link
        else
          " Get the absolute path of the current file's directory
          let current_file_dir = expand("%:h")
          " Get the absolute path of the clean_link file
          let clean_link_file = fnameescape(current_file_dir . '/' . clean_link)
          " Open the clean_link file in the editor
          execute 'e ' . clean_link_file
        endif
      endif
    endif
  endif
endfunction


function! wikimatic#JumpToNextMarkdownLink()
  " Define the Markdown link regex pattern
  let link_regex = '\[.*\]\((.*)\)'
  " Search for the next Markdown link in the current buffer
  let next_link_pos = search(link_regex, 'w')
  " Check if a Markdown link was found
  if next_link_pos != 0
    " Move the cursor to the next Markdown link
    call cursor(next_link_pos, 0)
  else
    " Display an error message if no Markdown link was found
    echohl ErrorMsg | echo "No more Markdown links found!" | echohl None
  endif
endfunction


function! wikimatic#JumpToPreviousMarkdownLink()
  " Define the Markdown link regex pattern
  let link_regex = '\[.*\]\((.*)\)'
  " Search for the previous Markdown link in the current buffer
  let prev_link_pos = search(link_regex, 'b')
  " Check if a Markdown link was found
  if prev_link_pos != 0
    " Move the cursor to the previous Markdown link
    call cursor(prev_link_pos, 0)
  else
    " Display an error message if no Markdown link was found
    echohl ErrorMsg | echo "No more Markdown links found!" | echohl None
  endif
endfunction
