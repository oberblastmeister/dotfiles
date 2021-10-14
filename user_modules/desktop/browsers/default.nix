{ options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.desktop.browsers;
  inherit (lib) mkOption types;
in
{
  options.modules.desktop.browsers = {
    default = mkOption {
      type = types.str;
      default = "firefox";
    };
  };

  config = {
    home.sessionVariables = {
      BROWSER = cfg.default;
    };
  };
}
