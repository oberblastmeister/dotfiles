{ config, options, lib, ... }:

let
  inherit (lib) types mkOption;
in

{
  options = {
    dotfiles = {
      # we use strings so the path is nice and doesn't point to nix store
      dir = mkOption {
        type = types.str;
        default = (
          lib.findFirst builtins.pathExists (toString ../.) [
            "/etc/dotfiles"
            "/etc/nixos"
          ]
        );
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
