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

    xdg.configFile."flameshot/flameshot.ini".source = iniFormat.generate "flameshot-settings.ini" cfg.settings;
  };
}
