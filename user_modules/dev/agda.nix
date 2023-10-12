{ options, config, pkgs, unstable, lib, my, ... }:

let
  cfg = config.modules.dev.agda;
in
{
  options.modules.dev.agda = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (agda.withPackages
        (p: [
          p.standard-library
          p.cubical
        ]))
    ];
  };
}
