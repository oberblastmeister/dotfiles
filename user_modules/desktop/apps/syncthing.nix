{ config, lib, my, unstable, pkgs, ... }:

let
  cfg = config.modules.desktop.apps.syncthing;
in
{
  options.modules.desktop.apps.syncthing = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
