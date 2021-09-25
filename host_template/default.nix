{ config, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    desktop = {
      gnome.enable = true;
    };
  };

  users.users.brian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.brian.modules.presets.enable = "full";
}
