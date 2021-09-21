{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ inputs.home-manager.nixosModules.home-manager ]
    ++ lib.my.modules.importAllRec' ./modules;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    autoOptimiseStore = true;
    binaryCaches = [
      "https://nix-community.cachix.org"
    ];
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = lib.mkDefault true;
      systemd-boot.enable = lib.mkDefault true;
    };
  };

  environment.systemPackages = with pkgs; [
    cached-nix-shell
    git
    vim
    curl
    wget
  ];
}
