{ options, config, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.terminals;
  inherit (lib) mkOption types;
in
{
  options.modules.desktop.terminals = {
    default = mkOption {
      type = types.str;
      default = "gnome-terminal";
    };
  };

  config = {
    home.sessionVariables = {
      TERMINAL = "gnome-terminal";
    };
  };
}