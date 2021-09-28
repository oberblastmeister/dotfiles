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
        default = config.dotfiles.dir + "/config";
      };
      naiveBinDir = mkOption {
        type = types.str;
        default = config.dotfiles.dir + "/bin";
      };
      naiveModulesDir = mkOption {
        type = types.str;
        default = config.dotfiles.dir + "/modules";
      };
      naiveUserModulesDir = mkOption {
        type = types.str;
        default = config.dotfiles.dir + "/user_modules";
      };
      dir = mkOption {
        type = types.path;
        default = ../.;
      };
      configDir = mkOption {
        type = types.path;
        default = config.dotfiles.realDir + "/config";
      };
      binDir = mkOption {
        type = types.path;
        default = config.dotfiles.realDir + "/bin";
      };
      modulesDir = mkOption {
        type = types.path;
        default = config.dotfiles.realDir + "/modules";
      };
      userModulesDir = mkOption {
        type = types.path;
        default = config.dotfiles.realDir + "/user_modules";
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
