{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps.flameshot;
in
{
  options.modules.desktop.apps.flameshot = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    services.flameshot.enable = true;
  };
}