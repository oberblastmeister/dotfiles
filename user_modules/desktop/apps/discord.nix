{ config, lib, my, very-unstable, ... }:

let
  cfg = config.modules.desktop.apps.discord;
in
{
  options.modules.desktop.apps.discord = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      very-unstable.discord
    ];
  };
}
