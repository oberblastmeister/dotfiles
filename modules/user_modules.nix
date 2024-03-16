{ system, config, lib, pkgs, inputs, dirs, ... }:

{
  home-manager = {
    # If true: Install user packages to /etc/profiles instead. Necessary for
    # nixos-rebuild build-vm to work.
    useUserPackages = false;

    # import: this allows to inherit options from pkgs in the flake
    # so we don't need to defined nixpkgs.config again in the home-manager section
    useGlobalPkgs = true;

    # give home-manager some extra arguments that we can receive in modules
    # similar to how we give lib.nixosSystem specialArgs
    extraSpecialArgs = {
      inherit (pkgs) old unstable very-unstable;
      inherit inputs system dirs;
      # inherit my instead of whole lib because home-manager needs to use
      # it's own special extended stdlib and it will clash with the lib name
      inherit (lib) my;
    };
    sharedModules = lib.my.modules.importAllRec' ../user_modules
      # Necessary for home-manager to work with flakes, otherwise it will
      # look for a nixpkgs channel.
      ++ [
      {
        home.stateVersion = lib.mkDefault config.system.stateVersion;
      }
    ];
  };
}
