{ options, config, lib, pkgs, ... }:

let
  cfg = config.modules.virtualisation.docker;
in
{
  options.modules.virtualisation.docker = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
