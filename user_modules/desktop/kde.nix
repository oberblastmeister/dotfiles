args@{ pkgs, ... }:

let
  cfg = args.config.modules.desktop.kde;
  inherit (args) lib;
in
{
  options.modules.desktop.kde = {
    enable = args.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    # let kde settings manager manage the gtk settings
    gtk.enable = lib.mkForce false;

    home.packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      latte-dock
    ];
  };
}
