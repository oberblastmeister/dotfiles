{ config, options, unstable, pkgs, lib, my, ... }:

let
  package = pkgs.ulauncher;
  cfg = config.modules.desktop.apps.ulauncher;
  inherit (lib) mkOption;
in
{
  options.modules.desktop.apps.ulauncher = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ package ];

    systemd.user.services.ulauncher = {
      Unit = {
        Description = "Ulauncher program launcher";
        Requires = [ "tray.target" ];
        After = [ "graphical-session-pre.target" "tray.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        ExecStart = "${package}/bin/ulauncher";
        Restart = "on-abort";
      };
    };
  };
}
