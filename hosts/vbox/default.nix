{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    desktop = {
      gnome.enable = true;
    };
  };

  programs.fish.enable = true;

  users.users.brian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  home-manager.users.brian.modules.presets.enable = "full";
}
