{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.modules.nix;
in
{
  options.modules.nix = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
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
          "https://hydra.iohk.io" # for haskell.nix
        ];
        binaryCachePublicKeys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" # for haskell.nix
        ];
      };

  };
}
