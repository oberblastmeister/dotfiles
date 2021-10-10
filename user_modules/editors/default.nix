{ options, config, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.editors;
  inherit (lib) mkOption types;
in
{
  options.modules.editors = {
    default = mkOption {
      type = types.str;
      default = "vim";
    };
    visual = mkOption {
      type = types.str;
      default = "code";
    };
  };

  config = {
    home.sessionVariables = {
      EDITOR = cfg.default;
      VISUAL = cfg.visual;
    };
  };
}