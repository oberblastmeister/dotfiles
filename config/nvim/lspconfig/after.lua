local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'
-- must be a slash between paths because this is how lspconfig does it
-- it using a dot it will return a different reference because of how lua caches
local configs = require 'lspconfig/configs'

return function(opts)
  local LspDefaults = opts.LspDefaults

  configs.notes_lsp = {
    default_config = {
      cmd = { '/home/brian/.local/bin/notes-lsp' },
      filetypes = { 'markdown' },
      root_dir = function(fname)
        return util.path.dirname(fname)
      end,
    },
  }

  lspconfig.notes_lsp.setup(LspDefaults)
end