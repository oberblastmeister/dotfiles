{ config, config', my, lib, pkgs, inputs, ... }:

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

    home.packages = with pkgs; [
      neovim
      neovim-remote
      nodePackages.neovim
      python39Packages.pynvim
    ];

    modules.shell.aliases = {
      "vim" = "nvim";
      "vi" = "nvim";
    };
    # 
    xdg.configFile = {
      "nvim".source = mkOutOfStoreSymlink (config'.dotfiles.configDir + "/nvim");
    };
    # xdg.configFile."nvim".source = config'.dotfiles.configDir + "/nvim";
  };
}
