{ system, config, lib, pkgs, inputs, ... }:

{
  home-manager = {
    # give home-manager some extra arguments that we can receive in modules
    # similar to how we give lib.nixosSystem specialArgs
    extraSpecialArgs = {
      inherit (pkgs) unstable;
      inherit inputs system;
      # inherit my instead of whole lib because home-manager needs to use
      # it's own special extended stdlib and it will clash with the lib name
      inherit (lib) my;
      config' = config;
    };
    sharedModules = lib.my.modules.importAllRec' ../user_modules
      # Necessary for home-manager to work with flakes, otherwise it will
      # look for a nixpkgs channel.
      ++ [
      {
        home.stateVersion = lib.mkDefault config.system.stateVersion;
        modules.presets.enable = lib.mkDefault "full";
      }
    ];
  };
}
