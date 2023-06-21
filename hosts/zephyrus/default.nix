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

  # this is very important to enable native wayland apps for stuff like electron (vscode, discord)
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.flatpak.enable = true;

  nix.settings.trusted-users = [ "root" "brian" ];

  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.bismuth
  ];

  modules = {
    desktop.gnome.enable = true;
    virtualisation = {
      # virt-manager.enable = true;
      # docker.enable = true;
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
  hardware.opengl.extraPackages32 = [
    pkgs.driversi686Linux.amdvlk
  ];

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

  programs.rog-control-center.enable = true;

  home-manager.users.brian = {
    modules = {
      presets.enable = "full";
      desktop = {
        apps.ulauncher.enable = true;
        dconf.enable = true;
        browsers.chrome.enable = true;
        browsers.firefox.enable = true;
        terminals.alacritty.enable = true;
      };
    };

    dconf.settings = {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
    };
  };
}
