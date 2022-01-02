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

  # this makes chinese work with the ibus input method
  # if using gnome, make sure to also add Chinese (Intelligent Pinyin) to input sources with regular Chinese
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [
    rime
    libpinyin
    table
    table-chinese
    m17n
  ];
}
