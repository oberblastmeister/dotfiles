{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.brian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  modules = {
    presets.enable = "full";
    hardware = {
      microcode.amd.enable = true;
    };
  };
  home-manager.users.brian.modules.presets.enable = "full";
}
