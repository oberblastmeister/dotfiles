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
      showHelp = false;
      showSidePanelButton = false;
      showStartupLaunchMessage = false;
    };
    home.file."${configDir}/flameshot/flameshot.ini" = mkIf (cfg.settings != { }) {
      source = iniFormat.generate "flameshot.ini" cfg.settings;
    };
  };
}
