require 'utils'
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
require 'nohl'

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = ' '
-- vim.g.conjure.mapping.doc_word = nil
vim.g["conjure#mapping#doc_word"] = '<C-S-K>'

