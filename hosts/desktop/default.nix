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

  nix.trustedUsers = [ "root" "brian" ];

  modules = {
    presets.enable = "full";
    virtualisation = {
      virt-manager.enable = true;
      virtualbox.enable = true;
      docker.enable = true;
    };
    hardware = {
      microcode.amd.enable = true;
      opengl.enable = true;
    };
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      brlaser
    ];
  };

  # amd stuff
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.extraPackages = [
    pkgs.amdvlk
  ];
  # To enable Vulkan support for 32-bit applications, also add:
  hardware.opengl.extraPackages32 = [
    pkgs.driversi686Linux.amdvlk
  ];

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
