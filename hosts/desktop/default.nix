{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.brian = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "networkmanager"
      "vboxusers"
      "docker"
    ];
  };

  modules = {
    presets.enable = "full";
    virtualisation = {
      virt-manager.enable = true;
      virtualbox.enable = true;
      docker.enable = true;
    };
    hardware = {
      microcode.amd.enable = true;
    };
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      brlaser
    ];
  };

  home-manager.users.brian.modules = {
    presets.enable = "full";
    desktop = {
      apps = {
        zoom.enable = true;
      };
      browsers.chrome.enable = true;
    };
  };
}
