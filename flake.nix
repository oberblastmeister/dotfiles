{
  description = "my system";

  inputs = {
    # primary nixpkgs
    # unstable is too unstable
    # make sure to change the version number to update
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-very-unstable.url = "github:NixOS/nixpkgs/master"; # for packages on the edge

    utils.url = "github:numtide/flake-utils";

    # might need to pin this to same version as nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # user flake stuff
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    dirbuf = {
      url = "github:elihunter173/dirbuf.nvim";
      flake = false;
    };
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
    };
    lf = {
      url = "github:gokcehan/lf";
      flake = false;
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-old, nixpkgs-unstable, nixpkgs-very-unstable, utils, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
          permittedInsecurePackages = [
            "electron-25.9.0"
            "nix-2.15.3"
            "openssl-1.1.1w" # for sublime4
          ];
        };
        overlays = extraOverlays ++ (builtins.attrValues self.overlays);
      };
      overlays = [
      ];
      pkgs-old = mkPkgs nixpkgs-old overlays;
      pkgs = mkPkgs nixpkgs overlays;
      pkgs-unstable = mkPkgs nixpkgs-unstable overlays;
      pkgs-very-unstable = mkPkgs nixpkgs-very-unstable overlays;
      lib = nixpkgs.lib.extend (final: prev: { my = import ./lib { inherit pkgs inputs; lib = final; }; });
    in
    rec {
      overlays = {
        default = final: prev: {
          old = pkgs-old;
          unstable = pkgs-unstable;
          very-unstable = pkgs-very-unstable;
          my = self.packages."${system}";
        };
      } // lib.my.modules.importAll ./overlays;

      nixosModules = {
        dotfiles = import ./.;
      } // lib.my.modules.importAll ./modules;

      nixosConfigurations = lib.my.hosts.map ./hosts { };

      # this stuff is for non nixos linux or macos
      homeConfigurations.brian = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./homes/laptop.nix
          ({ config, ... }:
            {
              imports = lib.my.modules.importAllRec' ./user_modules;

              # very import, makes icon and cursor themes work, and others stuff too
              targets.genericLinux.enable = true;

              home = {
                username = "brian";
                stateVersion = "22.05";
                homeDirectory = "/home/brian";
              };

              home.sessionVariables = {
                ANKI_WAYLAND = 1;
                ANOTHER = "another";
              };


              modules = {
                dev = {
                  python.enable = true;
                  rust.enable = true;
                  haskell.enable = true;
                  lean.enable = true;
                  agda.enable = true;
                  cc.enable = true;
                };
                fonts.enable = true;
                editors = {
                  vim.enable = true;
                  vscode.enable = true;
                };
                shell = {
                  programs.enable = true;
                  bash.enable = true;
                  fish.enable = true;
                };
                desktop = {
                  theme.enable = true;
                  apps = {
                    # ulauncher for some reason sets its python dependencies in the PATH of the process
                    # ulauncher.enableConfig = true;
                    # flameshot.enable = true;
                  };
                  dconf.enable = true;
                  # don't enable installing package, gpu accelerated programs don't work
                  terminals.alacritty.enableConfig = true;
                };
              };
            })
        ];

        extraSpecialArgs = {
          inherit (pkgs) unstable very-unstable;
          inherit inputs system;
          inherit (lib) my;
          dirs = import ./dirs.nix;
        };
      };

      templates = import ./templates;
    }
    // (utils.lib.eachSystem [ system ] (system:
      rec {
        packages = lib.my.modules.map ./packages (p: pkgs.callPackage p { }) // { };
      }));
}
