{ options, config, lib, pkgs, ... }:

let
  cfg = config.modules.virtualisation.podman;
in
{
  options.modules.virtualisation.podman = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman.enable = true;
  };
}
