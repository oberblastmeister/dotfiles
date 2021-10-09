{ options, config, unstable, pkgs, lib, my, ... }:
let
  cfg = config.modules.dev.lua;
in
{
  options.modules.dev.lua = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      lua
      luajit
    ];
  };
}
