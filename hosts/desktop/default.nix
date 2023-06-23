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

  nix.settings.trusted-users = [ "root" "brian" ];

  modules = {
    desktop.gnome.enable = true;
    virtualisation = {
      # virt-manager.enable = true;
      virtualbox.enable = true;
    };
  };
  virtualisation.docker.enable = true;

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
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [
    rime
    libpinyin
    table
    table-chinese
    m17n
  ];

  home-manager.users.brian = {
    modules = {
      fonts.enable = true;
      editors = {
        vim.enable = true;
        vscode.enable = true;
        emacs.enable = true;
      };
      dev = {
        rust.enable = true;
        haskell.enable = true;
        idris.enable = true;
        agda.enable = true;
        ocaml.enable = true;
        coq.enable = true;
        python.enable = true;
        cc.enable = true;
        markdown.enable = true;
        racket.enable = true;
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
        browsers.chrome.enable = true;
        terminals.alacritty.enable = true;
      };
    };
  };
}
