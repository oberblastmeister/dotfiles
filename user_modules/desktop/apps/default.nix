{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps;
  inherit (lib) mkOption;
in
{
  imports = [
    ./flameshot.nix
  ];

  options.modules.desktop.apps.enable = my.options.mkEnable;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      anki
      gource # git visualizer
      peek # simple gif recorder
      elementary-planner
      element-desktop
      discord
      mailspring
      gthumb
      mpv
    ];

    modules.desktop.apps = {
      flameshot.enable = true;
    };
  };
}
