{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps.flameshot;
  iniFormat = pkgs.formats.ini { };
  inherit (lib) mkOption;
  configDir = config.xdg.configHome;
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

    modules.desktop.apps.flameshot.settings = {
      General = {
        showHelp = false;
        showSidePanelButton = false;
        showStartupLaunchMessage = false;
      };
    };
    xdg.configFile."flameshot/flameshot.ini".source = lib.mkIf (cfg.settings != { }) {
      source = toString (iniFormat.generate "flameshot.ini" cfg.settings);
    };
  };
}
