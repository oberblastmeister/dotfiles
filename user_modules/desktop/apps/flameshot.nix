{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps.flameshot;
  iniFormat = pkgs.formats.ini { };
  inherit (lib) mkOption;
in
{
  options.modules.desktop.apps.flameshot = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    services.flameshot = {
      enable = true;
      # use unstable to avoid cannot capture screen issue
      # https://github.com/flameshot-org/flameshot/issues/1910
      # package = unstable.flameshot;
      settings = {
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
    };
  };
}
