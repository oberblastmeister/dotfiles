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

  home-manager.users.brian.modules = {
    editors = {
      vim.enable = true;
    };
  };
}
