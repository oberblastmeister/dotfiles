{ inputs, config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault;
in
{
  imports =
    [ inputs.home-manager.nixosModules.home-manager ]
    ++ lib.my.modules.importAllRec' ./modules;

  modules = {
    nix.enable = true;
    boot.systemd-boot.enable = mkDefault true;
  };

  time = {
    hardwareClockInLocalTime = mkDefault true;
    timeZone = "US/Eastern";
  };

  security = {
    sudo.enable = mkDefault true;

    # has some permission denied issues when installing fonts
    doas = {
      enable = mkDefault false;
      extraRules = [
        {
          groups = [ "wheel" ];
          # allow environment variables to be kept
          # must be kept on or stuff like NIX_PATH will fail
          keepEnv = true;
          # allow password to be skipped for a while
          persist = true;
        }
      ];
    };
  };

  networking = {
    # screws up containers like docker
    firewall.enable = false;

    # the installation environment enables this
    # gnome enables this
    # but other ones don't
    networkmanager.enable = mkDefault true;
  };

  # essentials
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    git
    vim
    curl
    wget
    gcc
    # full man pages
    man-pages
    man-pages-posix
  ];

  programs = {
    fish.enable = true;
    zsh.enable = true;
    # very buggy perl script
    # sometimes needs the channel to be there
    command-not-found.enable = false;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    fuse3
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libGL
    libappindicator-gtk3
    libdrm
    libnotify
    libpulseaudio
    libuuid
    libusb1
    xorg.libxcb
    libxkbcommon
    mesa
    nspr
    nss
    pango
    pipewire
    systemd
    icu
    openssl
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxkbfile
    xorg.libxshmfence
    zlib
    gmp5
    ncurses
    icu66
  ];

  users.defaultUserShell = pkgs.fish;

  # man pages for other utilities
  documentation.dev.enable = true;

  # use with nix profile install --impure
  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  hardware.enableAllFirmware = true;

  system.stateVersion = "22.05";
}
