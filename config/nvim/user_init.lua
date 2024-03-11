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

require 'autocommands'
require 'mappings/command'
require 'settings'
require 'local'
-- important to do this before lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})
require 'lsp'
require 'treesitter'

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = ' '
-- vim.g.conjure.mapping.doc_word = nil
vim.g["conjure#mapping#doc_word"] = '<C-S-K>'

