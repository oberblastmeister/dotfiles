{
  description = "my system";

  inputs = {
    # primary nixpkgs
    # unstable is too unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-very-unstable.url = "nixpkgs/master"; # for packages on the edge

    utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-very-unstable, utils, ... }@inputs:
    let
      system = "x86_64-linux";
      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ self.overlay ] ++ extraOverlays ++ (builtins.attrValues self.overlays);
      };
      overlays = [ ];
      pkgs = mkPkgs nixpkgs overlays;
      pkgs-unstable = mkPkgs nixpkgs-unstable overlays;
      pkgs-very-unstable = mkPkgs nixpkgs-very-unstable overlays;
      lib = nixpkgs.lib.extend (final: prev: { my = import ./lib { inherit pkgs inputs; lib = final; }; });
    in
    rec {
      overlay = final: prev: {
        unstable = pkgs-unstable;
        very-unstable = pkgs-very-unstable;
        my = self.packages."${system}";
      };

      overlays = lib.my.modules.importAll ./overlays;

      nixosModules = { dotfiles = import ./.; } // lib.my.modules.importAll ./modules;

      nixosConfigurations = lib.my.hosts.map ./hosts { };
    }
    // (utils.lib.eachSystem [ system ] (system:
      rec {
        packages = lib.my.modules.map ./packages (p: pkgs.callPackage p { }) // { };

        apps = {
          yo = {
            type = "app";
            program = ./bin/yo;
          };
        };

        defaultApp = apps.yo;

        devShell = import ./shell.nix pkgs;
      }));
}
