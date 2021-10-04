{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.brian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
