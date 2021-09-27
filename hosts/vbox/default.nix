{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.brian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  modules.presets.enable = "full";
  modules.hardware.opengl.enable = true;
  home-manager.users.brian.modules.presets.enable = "full";
}
