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
      gource
      elementary-planner
      element-desktop
      gthumb
      mpv
      celluloid
      peek
      qalculate-gtk
      zotero
      unstable.popsicle
      # insecure right now
      # obsidian
    ];
  };
}
