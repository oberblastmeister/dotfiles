{ config, lib, my, pkgs, unstable, ... }:

let
  cfg = config.modules.desktop.apps.misc;
in
{
  options.modules.desktop.apps.misc = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      anki
      mailspring
      gthumb
      mpv
      celluloid
      peek
      # insecure right now
      unstable.obsidian
    ];
  };
}
