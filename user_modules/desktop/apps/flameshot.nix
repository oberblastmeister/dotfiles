{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps.flameshot;
in
{
  options.modules.apps.flameshot = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.flameshot.enable = true;
  };
}