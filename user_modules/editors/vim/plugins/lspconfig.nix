{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  writeIf = cond: s: if cond then s else "";
  addIf = cond: x: if cond then [ x ] else [ ];
  devCfg = config.modules.dev;
  nvimConfigDir = nixosConfig.dotfiles.configDir + "/nvim";
  naiveNvimConfigDir = nixosConfig.dotfiles.naiveConfigDir + "/nvim";
  inherit (lib) types mkOption;
in
{
  options.modules.editors.vim.lspconfig.config = mkOption {
    type = types.str;
    default = ''
      lua << EOF
      
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig/configs'
      local util = require 'lspconfig/util'

      local function custom_on_attach(client, bufnr)
        vim.cmd [[source ${nvimConfigDir + /lspconfig/mappings.lua}]]
      end

      local LspDefaults = {
        on_attach = custom_on_attach,
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
    
      ${writeIf devCfg.python.enable "lspconfig.pyright.setup(LspDefaults)"}
      
      ${writeIf devCfg.rust.enable "lspconfig.rust_analyzer.setup(LspDefaults)"}
      
      ${writeIf devCfg.haskell.enable "lspconfig.hls.setup(LspDefaults)"}
      
      ${writeIf devCfg.ocaml.enable "lspconfig.ocamllsp.setup(LspDefaults)"}
      
      ${writeIf devCfg.cc.enable "lspconfig.clangd.setup(LspDefaults)"}
      
      lspconfig.vimls.setup(LspDefaults)

      lspconfig.jsonls.setup(LspDefaults)
      
      lspconfig.yamlls.setup(LspDefaults)
      
      lspconfig.bashls.setup(LspDefaults)

      lspconfig.rnix.setup(LspDefaults)
      
      dofile('${naiveNvimConfigDir + "/lspconfig/after.lua"}') {
        LspDefaults = LspDefaults,
      }

      EOF
    '';
  };

  config = {
    home.packages = with pkgs; (addIf devCfg.python.enable nodePackages.pyright)
      # ++ (addIf devCfg.haskell.enable haskell-language-server)
      ++ (addIf devCfg.ocaml.enable ocamlPackages.ocaml-lsp)
      ++ (addIf devCfg.cc.enable clang-tools) ++ [
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nodePackages.vim-language-server
      rnix-lsp
    ];
  };
}
