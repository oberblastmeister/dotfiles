{ config, options, lib, ... }:

let
  inherit (lib) types mkOption;
in

{
  options = {
    dotfiles = {
      naiveDir = mkOption {
        type = types.str;
        default = "/etc/dotfiles";
      };
      naiveConfigDir = mkOption {
        type = types.str;
        default = config.dotfiles.naiveDir + "/config";
      };
      naiveBinDir = mkOption {
        type = types.str;
        default = config.dotfiles.naiveDir + "/bin";
      };
      naiveModulesDir = mkOption {
        type = types.str;
        default = config.dotfiles.naiveDir + "/modules";
      };
      naiveUserModulesDir = mkOption {
        type = types.str;
        default = config.dotfiles.naiveDir + "/user_modules";
      };
      dir = mkOption {
        type = types.path;
        default = ../.;
      };
      configDir = mkOption {
        type = types.path;
        default = config.dotfiles.dir + "/config";
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
      DOTFILES = config.dotfiles.naiveDir;
      DOTFILES_CONFIG = config.dotfiles.naiveConfigDir;
      DOTFILES_BIN = config.dotfiles.naiveBinDir;
      PATH = [ config.dotfiles.naiveBinDir ];
    };
  };
}
