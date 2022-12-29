{ options, config, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.lean;
in
{
  options.modules.dev.lean = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      elan

      # for old lean (includes leanproject)
      mathlibtools
    ];
  };
}
