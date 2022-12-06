# Wikimatic

Wikimatic is a minimalistic, markdown-based wiki for (neo)Vim.

This plugin does not provide any markdown features or syntax highlighting;
instead, it offers a few tools to help you navigate and create wiki pages. It is
recommended that you use this plugin in conjunction with a markdown plugin for
Vim.

## Features

- open the wiki
- navigate between links
- create links and files

# How

Inside markdown files in the Wikimatic folder:

- `<enter>` on a link to open or create that file
- `<enter>` on a word or selection to create a link from it
- `<tab>` to move the cursor to the next link
- `<S-tab>` to move the cursor to the previous link

## Options

```
let g:wikimatic_path = '~/wiki'
```

## Commands

- Wiki: open the wiki page (index.md)
- WikiGo: navigate to markdown link
- WikiLink:
  - on a link: WikiGo
  - on a word: WikiLinkCursor
- WikiLinkVisual: create a link from visual selection
- WikiLinkCursor: create a link from the word under cursor
- WikiNextLink: move the cursor to the next link
- WikiPrevLink: move the cursor to the previous link
