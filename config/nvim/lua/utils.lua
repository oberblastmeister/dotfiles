-- globals
augroup = vim.api.nvim_create_augroup
autocmd = vim.api.nvim_create_autocmd
km = vim.keymap.set
o = vim.opt
cmd = vim.cmd

function set_indent(scope, size)
  -- number of spaces that a tab counts for
  scope.tabstop = size
  -- number of spaces to use for each step of autoindent
  scope.shiftwidth = size
  scope.softtabstop = size
end
