{ config, dirs, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.desktop.terminals.alacritty;
in

{
  options.modules.desktop.terminals.alacritty = {
    enable = my.options.mkEnable;
    enableConfig = my.options.mkEnable;
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.alacritty.enable = true;
    })
    (lib.mkIf (cfg.enable || cfg.enableConfig) {
      modules.link.config."alacritty/alacritty.yml" = "symlink";
    })
  ];
}
