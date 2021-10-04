{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps.flameshot;
  iniFormat = pkgs.formats.ini { };
  inherit (lib) mkOption;
in
{
  imports = abort "adf";

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
        uiColor = "#83a598";
        drawColor = "#8ec07c";
        contrastUiColor = "#458588";
        showHelp = false;
        showSidePanelButton = false;
        showStartupLaunchMessage = false;
        disabledTrayIcon = false;
        drawThickness = 2;
      };
    };

    home.file."${config.xdg.configHome}/flameshot/flameshot.ini" = lib.mkIf (cfg.settings != { }) {
      source = iniFormat.generate "flameshot.ini" cfg.settings;
    };
  };
}
