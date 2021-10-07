{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  options.modules.editors.vim = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-surround
        vim-commentary
      ];
    };

    modules.shell.aliases = {
      "vim" = "nvim";
      "vi" = "nvim";
    };

    # xdg.configFile = {
    #   "nvim".source = mkOutOfStoreSymlink (nixosConfig.dotfiles.naiveConfigDir + "/nvim");
    # };
  };
}
