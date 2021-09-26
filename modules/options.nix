{ config, options, lib, ... }:

let
  inherit (lib) types mkOption;
in

{
  options = {
    dotfiles = {
      dir = mkOption {
        type = types.str;
        default = "/etc/dotfiles";
      };
      configDir = mkOption {
        type = types.str;
        default = config.dotfiles.dir + "/config";
      };
      binDir = mkOption {
        type = types.str;
        default = config.dotfiles.dir + "/bin";
      };
      modulesDir = mkOption {
        type = types.str;
        default = config.dotfiles.dir + "/modules";
      };
      userModulesDir = mkOption {
        type = types.str;
        default = config.dotfiles.dir + "/user_modules";
      };
      realDir = mkOption {
        type = types.path;
        default = ../.;
      };
      realConfigDir = mkOption {
        type = types.path;
        default = config.dotfiles.realDir + "/config";
      };
      realBinDir = mkOption {
        type = types.path;
        default = config.dotfiles.realDir + "/bin";
      };
      realModulesDir = mkOption {
        type = types.path;
        default = config.dotfiles.realDir + "/modules";
      };
      realUserModulesDir = mkOption {
        type = types.path;
        default = config.dotfiles.realDir + "/user_modules";
      };
    };
  };

  config = {
    environment.variables = {
      DOTFILES = config.dotfiles.dir;
      DOTFILES_CONFIG = config.dotfiles.configDir;
      DOTFILES_BIN = config.dotfiles.binDir;
      PATH = [ config.dotfiles.binDir ];
    };
  };
}
