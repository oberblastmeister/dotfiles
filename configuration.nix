{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # uncomment stuff for efi
  boot.loader = {
    systemd-boot.enable = false;
    /* efi = { */
    /*   canTouchEfiVariables = true; */
    /*   efiSysMountPoint = "/boot/efi"; */
    /* }; */
    grub = {
      enable = true;
      version = 2;
      /* device = "nodev"; */
      device = "/dev/sda";
      /* efiSupport = true; */
      /* useOSProber = true; */
    };
  };

  # Enable networking.
  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # fonts = {
  #   fontDir.enable = true;
  #   fonts = with pkgs; [
  #     noto-fonts
  #     noto-fonts-emoji
  #   ];
  #   fontconfig.defaultFonts = {
  #       sansSerif = [ "Noto Sans" ];
  #       monospace = [ "Noto Mono" ];
  #   };
  # };

  # Set your time zone.
  services.localtime.enable = true;

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
  ];

  # Configure the nix package manager.
  nix = {
    package = pkgs.nixFlakes;
    autoOptimiseStore = true;
    trustedUsers = [ "root" "brian" "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Allow unfree packages from nixpkgs.
  nixpkgs.config.allowUnfree = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    libinput = {
      enable = true;
    };
  };

  # Enable the KDE Desktop Environment.
  /* services.xserver.displayManager.sddm = { */
  /*   enable = true; */
  /* }; */

/* services.xserver.desktopManager.xterm.enable = true; */ 
  services.xserver = {
    windowManager.bspwm = {
      enable = true;
      sxhkd.configFile = "/home/brian/.config/sxhkd/sxhkdrc";
    };

    displayManager = {
      defaultSession = "none+bspwm";
      lightdm = {
        enable = true;
        extraSeatDefaults = ''
        user-session=none+bspwm
        '';
        /* extraConfig = '' */
        
        /* ''; */
        /* greeters.tiny.enable = true; */
        /* greeters.gtk.enable = true; */
        greeters.pantheon.enable = true;
      };
    };
    desktopManager.xfce = {
      enable = true;
      enableXfwm = true;
    };
    desktopManager.plasma5.enable = false;
  };


  # Enable OpenGL.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable Docker.
  virtualisation.docker = {
    enable = true;
  };

  # Enable virtualbox
  virtualisation.virtualbox.host.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Enable flatpaks.
  xdg.portal.enable = true;
  services.flatpak.enable = true;

  # Define a user account.
  users.users.brian = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "vboxusers" "docker" ];
    shell = pkgs.zsh;
  };

  # must be anebled to add to /etc/shells
  # or lightdm won't work
  programs = {
    zsh.enable = true;
  };

  system.stateVersion = "21.05";

  # allow locations
  services.geoclue2.enable = true;

  environment.variables = {
    PATH = "$HOME/.cargo/bin:$HOME/bin:$HOME/.local/share/bin";
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

}
