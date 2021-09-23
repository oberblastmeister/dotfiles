{
  description = "my system";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # primary nixpkgs
    nixpkgs-unstable.url = "nixpkgs/master"; # for packages on the edge

    nixos-hardware.url = "github:nixos/nixos-hardware";

    utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, utils, ... }@inputs:
    let
      system = "x86_64-linux";
      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ self.overlay ] ++ extraOverlays ++ (builtins.attrValues self.overlays);
      };
      overlays = [];
      pkgs = mkPkgs nixpkgs overlays;
      pkgs-unstable = mkPkgs nixpkgs-unstable overlays;
      lib = nixpkgs.lib.extend (final: prev: { my = import ./lib { inherit pkgs inputs; lib = final; }; });
    in
      rec {
        overlay = final: prev: {
          unstable = pkgs-unstable;
          my = self.packages."${system}";
        };

        overlays = lib.my.modules.importAll ./overlays;

        nixosModules = { dotfiles = import ./.; } // lib.my.modules.importAll ./modules;

        nixosConfigurations = lib.my.hosts.map ./hosts {};
      }
      // (
        utils.lib.eachSystem [ system ] (
          system:
            rec {
              packages = lib.my.modules.map ./packages (p: pkgs.callPackage p {}) // {};

              apps = {
                yo = {
                  type = "app";
                  program = ./bin/yo;
                };
              };

              defaultApp = apps.yo;

              devShell = import ./shell.nix pkgs;
            }
        )
      );
}
