{ options, config, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.terminals;
  inherit (lib) mkOption types;
in
{
  config = {
    home.sessionVariables = {
      TERMINAL = "wezterm";
    };
  };
}
