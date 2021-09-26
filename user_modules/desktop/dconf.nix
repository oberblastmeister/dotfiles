{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.dconf;
in
{
  options.modules.desktop.dconf = {
    enable = my.options.mkEnable;
  };
  
  config = lib.mkIf cfg.enable {

  };
}
