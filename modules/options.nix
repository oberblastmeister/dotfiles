{ config, options, lib, ... }:

let
  inherit (lib) types mkOption;
in

{
  options = {
    dotfiles = {
      dir = {
        type = types.path;
        default = ../.;
      };
      binDir = mkOption {
        type = types.path;
        default = config.dotfiles.dir + "/bin";
      };
      modulesDir = mkOption {
        type = types.path;
        default = config.dotfiles.dir + "/modules";
      };
      userModulesDir = mkOption {
        type = types.path;
        default = config.dotfiles.dir + "/user_modules";
      };
    };
  };

  config = {
    environment.variables = {
      DOTFILES = config.dotfiles.dir;
      DOTFILES_BIN = config.dotfiles.binDir;
      PATH = [ config.dotfiles.binDir ];
    };
  };
}
