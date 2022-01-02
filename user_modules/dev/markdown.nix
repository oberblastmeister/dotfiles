{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.markdown;
in
{
  options.modules.dev.markdown = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pandoc
    ];
  };
}
