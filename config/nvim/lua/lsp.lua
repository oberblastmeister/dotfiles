local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'


-- coq
local coq = require "coq"
vim.g.coq_settings = {
  ["keymap.recommended"] = true,
  ["keymap.bigger_preview"] = nil,
  ["keymap.jump_to_mark"] = "<c-y>",
  ["keymap.manual_complete"] = "<c-n>",
}
vim.cmd [[autocmd! InsertEnter * COQnow -s]]

-- {{{ autopairs start
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = {
  ["keymap.recommended"] = false,
  ["keymap.bigger_preview"] = nil,
  ["keymap.jump_to_mark"] = "<c-y>",
  ["keymap.manual_complete"] = "<c-n>",
}

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
-- autopairs end }}}

local function custom_on_attach(client, bufnr)
    local api = vim.api

    vim.cmd [[command! -nargs=0 -buffer FormatLsp lua vim.lsp.buf.formatting()]]

    km('n', '<c-]>', require"telescope.builtin".lsp_definitions, { buffer = true })
    km('n', 'K', vim.lsp.buf.hover, { buffer = true })

    api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true})

    api.nvim_buf_set_keymap(0, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true})

    -- references
    api.nvim_buf_set_keymap(0, 'n', 'gr', "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", {noremap = true}) -- fuzzy references

    -- symbols
    api.nvim_buf_set_keymap(0, 'n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {noremap = true})

    -- format with lsp
    api.nvim_buf_set_keymap(0, 'n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR><cmd>echo "Formatted!"<CR>', {noremap = true})

    -- actions
    api.nvim_buf_set_keymap(0, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})

    -- calls
    api.nvim_buf_set_keymap(0, 'n', '<leader>li', '<cmd>lua vim.lsp.buf.incoming_call()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', '<leader>lo', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', {noremap = true})

    -- diagnostic
    api.nvim_buf_set_keymap(0, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', ']g', '<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', '[g', '<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>', {noremap = true})

    -- client.server_capabilities.semanticTokensProvider = nil
end

local InitialLspDefaults = {
    on_attach = custom_on_attach,
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
LspDefaults = coq.lsp_ensure_capabilities(InitialLspDefaults)

function LspDefaults:with(user_config)
    return vim.tbl_extend("keep", user_config, self)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,

    signs = false,

    virtual_text = false,

    -- virtual_text = {
        --   spacing = 1,
        --   prefix = ' ',
        -- },

        update_in_insert = true,
    }
    )

lspconfig.pyright.setup(LspDefaults)

lspconfig.rust_analyzer.setup(InitialLspDefaults)

lspconfig.hls.setup(LspDefaults)

lspconfig.ocamllsp.setup(LspDefaults)

lspconfig.clangd.setup(LspDefaults)

lspconfig.vimls.setup(LspDefaults)

lspconfig.jsonls.setup(LspDefaults)

lspconfig.yamlls.setup(LspDefaults)

lspconfig.bashls.setup(LspDefaults)

lspconfig.rnix.setup(LspDefaults)

lspconfig.racket_langserver.setup(LspDefaults)
