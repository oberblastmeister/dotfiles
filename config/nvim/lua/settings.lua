print('yo')

vim.g.mapleader = ' '

o.termguicolors = true
o.number = true
o.relativenumber = true

-- use system clipboard
o.clipboard:prepend { 'unnamed', 'unnamedplus' }

-- live search and replace
o.inccommand=nosplit

-- don't show mode or command (has status line)
o.showmode = false
o.showcmd = false

o.ignorecase = true
o.smartcase = true

-- allow mouse to be used for everything
o.mouse = 'a'

-- don't wrap text
o.wrap = false

-- tabs/spaces setting
o.expandtab = true
-- number of spaces that a tab counts for
o.tabstop = 4
-- number of spaces to use for each step of autoindent
o.shiftwidth = 4
o.softtabstop = 4
o.autoindent = true

o.hidden = true
