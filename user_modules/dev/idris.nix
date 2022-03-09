{ options, config, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.idris;
in
{
  options.modules.dev.idris = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable { 
    home.packages = with pkgs; [
      idris
      idris2
    ];
  };
}