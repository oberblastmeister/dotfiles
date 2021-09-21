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
}
