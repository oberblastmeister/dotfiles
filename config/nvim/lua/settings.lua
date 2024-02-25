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
o.autoindent = true
set_indent(o, 4)

o.hidden = true
