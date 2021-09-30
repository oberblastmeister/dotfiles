{ options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.shell.zsh;
  inherit (my.options) mkEnable;
in
{
  options.modules.shell.zsh = {
    enable = mkEnable;
  };

  config = lib.mkIf cfg.enable { };
}
