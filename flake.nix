{
  description = "my system";

  inputs = {
    # primary nixpkgs
    # unstable is too unstable
    # make sure to change the version number to update
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-very-unstable.url = "github:NixOS/nixpkgs/master"; # for packages on the edge

    utils.url = "github:numtide/flake-utils";

    # might need to pin this to same version as nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
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
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-very-unstable, utils, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      mkPkgs = pkgs: extraOverlays: import pkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = extraOverlays ++ (builtins.attrValues self.overlays);
      };
      overlays = [
      ];
      pkgs = mkPkgs nixpkgs overlays;
      pkgs-unstable = mkPkgs nixpkgs-unstable overlays;
      pkgs-very-unstable = mkPkgs nixpkgs-very-unstable overlays;
      lib = nixpkgs.lib.extend (final: prev: { my = import ./lib { inherit pkgs inputs; lib = final; }; });
    in
    rec {
      overlays = {
        default = final: prev: {
          unstable = pkgs-unstable;
          very-unstable = pkgs-very-unstable;
          my = self.packages."${system}";
        };
      } // lib.my.modules.importAll ./overlays;

      nixosModules = {
        dotfiles = import ./.;
      } // lib.my.modules.importAll ./modules;

      nixosConfigurations = lib.my.hosts.map ./hosts { };

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

              # gtk = {
              #   enable = true;

              #   iconTheme = {
              #     name = "Papirus-Dark";
              #     package = pkgs.papirus-icon-theme;
              #   };
              # };

              home.packages = with pkgs; [
                # gnomeExtensions.blur-my-shell
              ];

              modules = {
                dev = {
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
                  fish.enable = true;
                };
                desktop = {
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
