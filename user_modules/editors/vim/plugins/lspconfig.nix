{ config, dirs, my, lib, pkgs, inputs, ... }:

let
  writeIf = cond: s: if cond then s else "";
  addIf = cond: x: if cond then [ x ] else [ ];
  devCfg = config.modules.dev;
  nvimConfigDir = dirs.configDir + "/nvim";
  naiveNvimConfigDir = dirs.naiveConfigDir + "/nvim";
  inherit (lib) types mkOption;
in
{
  options.modules.editors.vim.lspconfig.config = mkOption {
    type = types.str;
    default = ''
      lua << EOF
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
