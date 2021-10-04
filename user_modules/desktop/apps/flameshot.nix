{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps.flameshot;
  iniFormat = pkgs.formats.ini { };
in
{
  options.modules.desktop.apps.flameshot = {
    enable = my.options.mkEnable;
    settings = mkOption {
      type = iniFormat.type;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    services.flameshot.enable = true;

    xdg.configFile."flameshot".source = iniFormat.generate "flameshot-settings" cfg.settings;
  };
}
