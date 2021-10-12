{ options, config, lib, pkgs, ... }:

# see https://nixos.wiki/wiki/VirtualBox
let
  cfg = config.modules.virtualisation.virtualbox;
in
{
  options.modules.virtualisation.virtualbox = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
  };
}
