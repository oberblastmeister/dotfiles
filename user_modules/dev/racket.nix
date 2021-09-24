{ options, config, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.racket;
in
{
  options.modules.dev.racket = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      racket
    ];
  };
}
