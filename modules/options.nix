{ config, options, lib, ... }:

let
  inherit (lib) types mkOption;
in

{
  options = {
    dotfiles = {
      dir = mkOption {
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
      DOTFILES = toString config.dotfiles.dir;
      DOTFILES_BIN = toString config.dotfiles.binDir;
      PATH = [ (toString config.dotfiles.binDir) ];
    };
  };
}
