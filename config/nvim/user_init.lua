-- globals
augroup = vim.api.nvim_create_augroup
autocmd = vim.api.nvim_create_autocmd
km = vim.keymap.set
o = vim.opt
cmd = vim.cmd

require 'autocommands'
require 'mappings/command'
require 'settings'

