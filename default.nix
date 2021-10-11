{ inputs, config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault;
in
{
  imports =
    [ inputs.home-manager.nixosModules.home-manager ]
    ++ lib.my.modules.importAllRec' ./modules;

  nix =
    let
      filteredInputs = lib.filterAttrs (n: _: n != "self") inputs;
      nixPathInputs = lib.mapAttrsToList (n: v: "${n}=${v}") filteredInputs;
      registryInputs = lib.mapAttrs (_: v: { flake = v; }) filteredInputs;
    in
    {
      package = pkgs.nixFlakes;
      extraOptions = "experimental-features = nix-command flakes";
      # allows stuff like <nixpkgs> to find the correct one
      nixPath = nixPathInputs ++ [
        "nixpkgs-overlays=${config.dotfiles.dir}/overlays"
        "dotfiles=${config.dotfiles.dir}"
      ];
      # flake registries with `nix registry`
      registry = registryInputs // { dotfiles.flake = inputs.self; };
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
    firewall.enable = mkDefault true;
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
  ];

  programs = {
    fish.enable = true;
    zsh.enable = true;
    # very buggy perl script
    # sometimes needs the channel to be there
    command-not-found.enable = false;
  };

  users.defaultUserShell = pkgs.fish;
}
