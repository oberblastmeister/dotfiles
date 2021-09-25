{ config, options, lib, ... }:

let
  inherit (lib) types mkOption;
in

{
  options = {
    dotfiles = {
      # we use strings so the path is nice and doesn't point to nix store
      dir = {
        type = types.str;
        default = (
          findFirst pathExists (toString ../.) [
            "~/.config/dotfiles"
            "/etc/dotfiles"
          ]
        );
      };
      binDir = mkOption {
        type = type.str;
        default = config.dotfiles.dir + "/bin";
      };
      modulesDir = mkOption {
        type = type.str;
        default = config.dotfiles.dir + "/modules";
      };
      userModulesDir = mkOption {
        type = type.str;
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
