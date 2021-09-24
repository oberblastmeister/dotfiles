{ config, config', options, unstable, pkgs, lib, my, ... }:

let
  cfg' = config'.modules.desktop.gnome;
in
{
  config = lib.mkIf cfg'.enable {
    
  };
}
