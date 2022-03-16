{ options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.shell.bash;
  inherit (my.options) mkEnable;
in
{
  options.modules.shell.bash = {
    enable = mkEnable;
  };

  config = lib.mkIf cfg.enable { };
}
