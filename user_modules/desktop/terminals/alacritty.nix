{ config, dirs, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.desktop.terminals.alacritty;
in

{
  options.modules.desktop.terminals.alacritty = {
    enable = my.options.mkEnable;
    enableConfig = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };
  } // lib.mkIf (cfg.enableConfig || cfg.enable) {
    modules.link.config."alacritty/alacritty.yml" = "symlink";
  };
}
