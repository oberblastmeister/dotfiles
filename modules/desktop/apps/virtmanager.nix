{ options, config, lib, pkgs, ... }:

# see https://nixos.wiki/wiki/Virt-manager
let
  cfg = config.modules.desktop.apps.virtmanager;
in
{
  options.modules.desktop.apps.virtmanager = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager ];
  };
}
