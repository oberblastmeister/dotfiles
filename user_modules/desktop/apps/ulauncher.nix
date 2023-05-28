{ config, options, unstable, pkgs, lib, my, ... }:

let
  package = pkgs.ulauncher;
  cfg = config.modules.desktop.apps.ulauncher;
  inherit (lib) mkOption;
in
{
  options.modules.desktop.apps.ulauncher = {
    enable = my.options.mkEnable;
    enableConfig = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ package ];
  } // lib.mkIf (cfg.enableConfig || cfg.enable) {
    modules.link.config."autostart/Ulauncher.desktop" = "copy";
  };
}
