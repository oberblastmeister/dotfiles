{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps.flameshot;
  iniFormat = pkgs.formats.ini { };
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
        contrastUiColor = "#458588";
        uiColor = "#83a598";
        drawColor = "#8ec07c";
        disabledTrayIcon = false;
        drawThickness = 2;
        # saveAfterCopyPath=/home/brian/Pictures
        # savePath=/home/brian/Pictures
        # savePathFixed=false;
        # setSaveAsFileExtension=Portable Network Graphic file (PNG) (*.png)
        showHelp = false;
        showSidePanelButton = false;
        showStartupLaunchMessage = false;
      };
    };

    home.file."${configDir}/flameshot/flameshot.ini" = /* mkIf (cfg.settings != { }) */ {
      source = iniFormat.generate "flameshot.ini" {
        General = {
          contrastUiColor = "#458588";
          uiColor = "#83a598";
          drawColor = "#8ec07c";
          disabledTrayIcon = false;
          drawThickness = 2;
          # saveAfterCopyPath=/home/brian/Pictures
          # savePath=/home/brian/Pictures
          # savePathFixed=false;
          # setSaveAsFileExtension=Portable Network Graphic file (PNG) (*.png)
          showHelp = false;
          showSidePanelButton = false;
          showStartupLaunchMessage = false;
        };
      };
    };
  };
}
