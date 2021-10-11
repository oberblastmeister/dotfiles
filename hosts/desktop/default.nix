{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.brian = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
  };

  modules = {
    presets.enable = "full";
    desktop = {
      apps.virtmanager.enable = true;
    };
    hardware = {
      microcode.amd.enable = true;
    };
  };

  home-manager.users.brian.modules = {
    presets.enable = "full";
    desktop = {
      apps = {
        zoom.enable = true;
      };
    };
  };
}
