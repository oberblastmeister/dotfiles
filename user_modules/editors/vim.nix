{ config, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  inherit (lib) mkOption types;
in
{
  options.modules.editors.vim = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

    programs.neovim.enable = true;

    home.packages = with pkgs; [
      neovim-remote
      nodePackages.neovim
      python39Packages.pynvim
    ];
  };
}