{ options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.desktop.browsers.firefox;
in
{
  options.modules.desktop.browsers.firefox = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox

      # (
      #   pkgs.makeDesktopItem {
      #     name = "firefox-private";
      #     desktopName = "Firefox (Private)";
      #     genericName = "Open a private Firefox window";
      #     icon = "firefox";
      #     exec = "${firefox-bin}/bin/firefox --private-window";
      #     categories = "Network";
      #   }
      # )
    ];
  };
}
