{ options, config, lib, pkgs, ... }:

# see https://nixos.wiki/wiki/VirtualBox
let
  cfg = config.modules.desktop.apps.virtualbox;
in
{
  options.modules.desktop.apps.virtualbox = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
  };
}