{
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
    rust-overlay.url = "github:oxalica/rust-overlay";
    naersk.url = "github:nmattia/naersk";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, utils, ... }@inputs:
    let
      /* inherit (lib.my) */
      system = "x86_64-linux";
      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ self.overlay ] ++ extraOverlays ++ (builtins.attrValues self.overlays);
      };
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        inputs.rust-overlay.overlay
      ];
      pkgs = mkPkgs nixpkgs overlays;
      pkgs-unstable = mkPkgs nixpkgs-unstable overlays;
      lib = nixpkgs.lib.extend
        (final: prev: { my = import ./lib { inherit pkgs inputs; lib = prev; }; });
      naersk-lib = inputs.naersk.lib."${system}".override {
        rustc = pkgs.rust-bin.stable.latest.default;
        cargo = pkgs.rust-bin.stable.latest.default;
      };
      # packages for this system only
      system_packages = self.packages."${system}";
    in
      rec {
        overlay = final: prev: {
          unstable = pkgs-unstable;
          my = self.packages."${system}";
        };

        overlays = {};

        nixosModules =
          { dotfiles = import ./.; } // lib.my.modules.map ./modules import;

        nixosConfigurations = lib.my.hosts.map ./hosts {};
      } // (
        utils.lib.eachDefaultSystem (
          system:
            rec {
              packages = lib.my.modules.map ./packages (p: pkgs.callPackage p {}) // {
                yo = import ./yo { inherit naersk-lib; };
              };

              defaultPackage = packages.yo;

              apps = {
                yo = utils.lib.mkApp { drv = packages.yo; };
              };

              defaultApp = apps.yo;
            }
        )
      );
}
