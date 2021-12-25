{ options, config, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.coq;
in
{
  options.modules.dev.coq = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      coq
    ];
  };
}
