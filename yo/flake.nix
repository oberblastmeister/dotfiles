{
  description = "A command line tool to manage nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    crate2nix = {
      url = "github:kolloch/crate2nix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, rust-overlay, crate2nix, ... }:
    let
      # If you change the name here, you must also do it in Cargo.toml
      name = "yo";
      rustChannel = "stable";
    in
      utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ]
        (
          system:
            let
              # Imports
              pkgs = import nixpkgs {
                inherit system;
                overlays = [
                  rust-overlay.overlay
                  (
                    self: super: {
                      # Because rust-overlay bundles multiple rust packages into one
                      # derivation, specify that mega-bundle here, so that crate2nix
                      # will use them automatically.
                      rustc = self.rust-bin.${rustChannel}.latest.default;
                      cargo = self.rust-bin.${rustChannel}.latest.default;
                    }
                  )
                ];
              };
              inherit (import "${crate2nix}/tools.nix" { inherit pkgs; }) generatedCargoNix;

              customBuildRustCrateForPkgs = pkgs: pkgs.buildRustCrate.override {
                defaultCrateOverrides = pkgs.defaultCrateOverrides // {
                  ${name} = oldAttrs: {
                    inherit buildInputs nativeBuildInputs;
                  };
                };
              };

              cargoNix = generatedCargoNix {
                inherit name;
                src = ./.;
              };

              generatedBuild = import cargoNix {
                inherit pkgs;
                buildRustCrateForPkgs = customBuildRustCrateForPkgs;
              };

              # Configuration for the non-Rust dependencies
              buildInputs = with pkgs; [ openssl.dev ];
              nativeBuildInputs = with pkgs; [ rustc cargo pkgconfig ];
            in
              rec {
                packages.${name} = generatedBuild.rootCrate.build;

                # `nix build`
                defaultPackage = packages.${name};

                # `nix run`
                apps.${name} = utils.lib.mkApp {
                  inherit name;
                  drv = packages.${name};
                };

                defaultApp = apps.${name};

                # `nix develop`
                devShell = pkgs.mkShell
                  {
                    inputsFrom = builtins.attrValues self.packages.${system};
                    buildInputs = buildInputs ++ (
                      with pkgs;
                      # Tools you need for development go here.
                      [
                        nixpkgs-fmt
                        cargo-watch
                        pkgs.rust-bin.${rustChannel}.latest.rust-analysis
                        pkgs.rust-bin.${rustChannel}.latest.rls
                      ]
                    );
                  };
              }
        );
}
