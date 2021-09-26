{ config, options, lib, ... }:

let
  inherit (lib) types mkOption;
in

{
  options = {
    dotfiles = {
      dir = mkOption {
        type = types.str;
        default = lib.findFirst builtins.pathExists (toString ../.) [
          "/etc/dotfiles"
          "/etc/nixos"
        ];
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
      DOTFILES_BIN = config.dotfiles.binDir;
      PATH = [ config.dotfiles.binDir ];
    };
  };
}
