{ config, lib, my, pkgs, ... }:

let
  cfg = config.modules.desktop.apps;
  inherit (lib) mkDefault;
in
{
  options.modules.desktop.apps = {
    enableAll = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enableAll {
    modules.desktop.apps = {
      misc.enable = mkDefault true;
      flameshot.enable = mkDefault true;
      ulauncher.enable = mkDefault true;
      zathura.enable = mkDefault true;
    };
  };
}
