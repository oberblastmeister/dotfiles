{ config, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.desktop.terminals.alacritty;
in

{
  options.modules.desktop.terminals.alacritty = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = { };
  };
}
