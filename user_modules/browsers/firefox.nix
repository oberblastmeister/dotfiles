{ options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.browsers.firefox;
in
{
  options.modules.browsers.firefox = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox
      (
        lib.makeDesktopItem {
          name = "firefox-private";
          desktopName = "Firefox (Private)";
          genericName = "Open a private Firefox window";
          icon = "firefox";
          exec = "${firefox-bin}/bin/firefox --private-window";
          categories = "Network";
        }
      )
    ];
  };
}
