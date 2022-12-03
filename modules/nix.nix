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
        extraOptions = ''
          experimental-features = nix-command flakes

          keep-outputs = true
          keep-derivations = true
        '';
        # allows stuff like <nixpkgs> to find the correct one
        nixPath = nixPathInputs ++ [
          "nixpkgs-overlays=${config.dotfiles.dir}/overlays"
          "dotfiles=${config.dotfiles.dir}"
        ];
        # flake registries with `nix registry`
        registry = registryInputs // { dotfiles.flake = inputs.self; };
        settings = {
          auto-optimise-store = true;
          substituters = [
            "https://nix-community.cachix.org"
            # "https://cache.iog.io"
            "https://oberblastmeister-dotfiles.cachix.org"
            "https://lean4.cachix.org/"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            # "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
            "oberblastmeister-dotfiles.cachix.org-1:No99K5o9+Ab7Hq2CFgNZQQjDqlQIQzNkrA3FING6OrE="
            "lean4.cachix.org-1:mawtxSxcaiWE24xCXXgh3qnvlTkyU7evRRnGeAhD4Wk="
          ];
        };
      };

    # must be set so cli commands such as `nix-env` and `nix profile` work
    environment.variables.NIXPKGS_ALLOW_UNFREE = "1";
  };
}
