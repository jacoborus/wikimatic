# Wikimatic

Wikimatic is a minimalistic, markdown-based wiki for (neo)Vim.

This plugin does not provide any markdown features or syntax highlighting;
instead, it offers a few tools to help you navigate and create wiki pages. It is
recommended that you use this plugin in conjunction with a markdown plugin for
Vim.

## Features

- Shortcuts to open the wiki, diary, and navigate between links and diary pages

Inside markdown files in the Wik folder:

- `gf` on link to open or create that file
- `<enter>` on link to open or create that file
- `<enter>` on a **W**ord or selection to create a link from it

## Options

Wiki:

- wikPath: path of the main wiki folder
- wikPath4: path of the wiki 4 folder
- wikSpaces: string - indicates the character to replace the spaces

Diary:

- wikDiaryPath: path of the main wiki folder
- wikDiaryYear: boolean - create folders for years inside diary

## Commands

Wiki:

- Wik: when in a wiki, open its index, otherwise, open default wiki
- Wik 0: open default wiki index
- Wik 6: open wiki 6 index
- WikGo: navigate or create the link under cursor
- WikCreateLink: create a link from word or selection
- WikGoOrCreate: navigate to link or create the page if it doesn't exitst

Diary:

- WikDiary: open diary folder
- WikYear: open year folder in diary (only when wikDiaryYear is on)
- WikToday: open/create todays page in diary
- WikPrevLink: move cursor to previous link
- WikNextLink: move cursor to next link
- WikPrevDay: navigate to previous diary page
- WikNextDay: navigate to next diary page
- WikDay YYYY-MM-DD: open or create the page of that day
