{ inputs, config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault;
in
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
    binaryCachePublicKeys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = mkDefault true;
      systemd-boot.enable = mkDefault true;
      systemd-boot.configurationLimit = mkDefault 10;
    };
  };

  programs = {
    fish.enable = true;
    zsh.enable = true;
  };
  users.defaultUserShell = pkgs.fish;

  security = {
    sudo.enable = mkDefault false;
    doas = {
      enable = mkDefault true;
      extraRules = {
        groups = [ "wheel" ];
        # allow environment variables to be kept
        # must be kept on or stuff like NIX_PATH will fail
        keepEnv = true;
        # allow password to be skipped for a while
        persist = true;
      };
    };
  };

  # essentials
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    git
    vim
    curl
    wget
  ];
}
