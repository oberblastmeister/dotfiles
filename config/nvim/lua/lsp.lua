local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

-- coq
local coq = require "coq"
vim.cmd [[autocmd! InsertEnter * COQnow -s]]

local function custom_on_attach(client, bufnr)
    local api = vim.api

    vim.cmd [[command! -nargs=0 -buffer FormatLsp lua vim.lsp.buf.formatting()]]

    api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true})

    api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
    -- api.nvim_buf_set_keymap(0, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true})

    -- references
    api.nvim_buf_set_keymap(0, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', 'gr', "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", {noremap = true}) -- fuzzy references

    -- symbols
    api.nvim_buf_set_keymap(0, 'n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {noremap = true})

    -- format with lsp
    api.nvim_buf_set_keymap(0, 'n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR><cmd>echo "Formatted!"<CR>', {noremap = true})

    -- actions
    api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})

    -- calls
    api.nvim_buf_set_keymap(0, 'n', '<leader>li', '<cmd>lua vim.lsp.buf.incoming_call()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', '<leader>lo', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', {noremap = true})

    -- diagnostic
    api.nvim_buf_set_keymap(0, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', ']g', '<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>', {noremap = true})
    api.nvim_buf_set_keymap(0, 'n', '[g', '<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>', {noremap = true})
end

local LspDefaults = {
    on_attach = custom_on_attach,
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

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

lspconfig.rust_analyzer.setup(LspDefaults)

lspconfig.hls.setup(LspDefaults)

lspconfig.ocamllsp.setup(LspDefaults)

lspconfig.clangd.setup(LspDefaults)

lspconfig.vimls.setup(LspDefaults)

lspconfig.jsonls.setup(LspDefaults)

lspconfig.yamlls.setup(LspDefaults)

lspconfig.bashls.setup(LspDefaults)

lspconfig.rnix.setup(LspDefaults)

lspconfig.racket_langserver.setup(LspDefaults)
