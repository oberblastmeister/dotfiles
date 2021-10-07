{ config, lib, my, unstable, pkgs, ... }:

let
  cfg = config.modules.desktop.apps.zoom;
in
{
  options.modules.desktop.apps.zoom = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zoom-us
    ];
  };
}