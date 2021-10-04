{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps.flameshot;
  iniFormat = pkgs.formats.ini { };
  inherit (lib) mkOption;
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

    home.file."${config.xdg.configHome}/flameshot/flameshot.ini" = lib.mkIf (cfg.settings != { }) {
      source = iniFormat.generate "flameshot.ini" cfg.settings;
    };
  };
}
