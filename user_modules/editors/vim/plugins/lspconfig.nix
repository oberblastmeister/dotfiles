{ config, vimPlugins }:

let
  writeIf = cond: s: if cond then s else "";
  cfg = config.modules.dev;
in
{
  plugin = vimPlugins.nvim-lspconfig;
  config = ''
    ${writeIf cfg.python.enable "lspconfig.pyright.setup()"}
  '';
}

