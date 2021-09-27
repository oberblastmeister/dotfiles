{ options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.shell.fish;
  inherit (my.options) mkEnable;
in
{
  options.modules.shell.fish = {
    enable = mkEnable;
  };

  config = lib.mkIf cfg.enable {};
}
