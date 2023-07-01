{ config, lib, old, pkgs, ... }:


{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
  environment.sessionVariables = {
    # still experimental
    # NIXOS_OZONE_WL = "1";
    DISABLE_QT5_COMPAT = "1";
  };

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

  # run android apps on wayland
  # virtualisation.waydroid.enable = true;

  modules = {
    # desktop.gnome.enable = true;
    desktop.kde.enable = true;
    # doesn't work with disable touchpad while typing
    # kanata.enable = true;
    virtualisation = {
      # virt-manager.enable = true;
      # virtualbox.enable = true;
    };
  };
  virtualisation.podman.enable = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      brlaser
    ];
  };

  # amd stuff
  # video drivers
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.extraPackages = [
    pkgs.amdvlk
  ];
  hardware.opengl.extraPackages32 = [
    pkgs.driversi686Linux.amdvlk
  ];
  hardware.opengl = {
    enable = true;

    # enable vulkan support
    driSupport = true;
    # For 32 bit applications
    driSupport32Bit = true;

    # extraPackages = with pkgs; [
    #   libGL
    #   vaapiVdpau
    #   libvdpau-va-gl
    # ];
  };

  # this makes chinese work with the ibus input method
  # if using gnome, make sure to also add Chinese (Intelligent Pinyin) to input sources with regular Chinese
  # i18n.inputMethod = {
  #   enabled = "ibus";
  #   ibus.engines = with pkgs.ibus-engines; [
  #     rime
  #     libpinyin
  #     table
  #     table-chinese
  #     m17n
  #   ];
  # };

  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-gtk
  #     fcitx5-rime
  #   ];
  # };

  programs.rog-control-center.enable = true;
  programs.rog-control-center.autoStart = true;

  # make flatpak font stuff work
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.fonts;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    # Create an FHS mount to support flatpak host icons/fonts
    "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
  };

  home-manager.users.brian = {
    home.packages = with pkgs; [
      anki-bin
      # insecure right now
      unstable.obsidian
    ];

    modules = {
      desktop.kde.enable = true;
      fonts.enable = true;
      editors = {
        vim.enable = true;
        vscode.enable = true;
        emacs.enable = true;
      };
      dev = {
        rust.enable = true;
        haskell.enable = true;
        # idris.enable = true;
        agda.enable = true;
        ocaml.enable = true;
        # coq.enable = true;
        python.enable = true;
        cc.enable = true;
        markdown.enable = true;
        # racket.enable = true;
        javascript.enable = true;
        lean.enable = true;
        # java.enable = true;
        # latex.enable = true;
      };
      shell = {
        fish.enable = true;
        bash.enable = false;
        programs.enable = true;
      };
      desktop = {
        theme.enablePackages = true;
        browsers.chrome.enable = true;
        browsers.firefox.enable = true;
        terminals.alacritty.enable = true;
      };
    };
  };
}
