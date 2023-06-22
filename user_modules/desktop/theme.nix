{ config, my, lib, pkgs, ... }:

let
  cfg = config.modules.desktop.theme;
in
{
  options.modules.desktop.theme = {
    enable = my.options.mkEnable;
    enableGtk = my.options.mkEnable;
    enablePackages = my.options.mkEnable;
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.enable || cfg.enableGtk) {
      gtk = {
        enable = true;

        theme = {
          name = "Orchis-Dark";
        };

        iconTheme = {
          # name = "Papirus-Dark";
          name = "Tela-circle-dark";
        };

        cursorTheme = {
          name = "Bibata-Modern-Ice";
        };
      };
    })
    (lib.mkIf (cfg.enable || cfg.enablePackages) {
      home.packages = with pkgs; [
        flat-remix-gtk
        flat-remix-gnome
        orchis-theme
        papirus-icon-theme
        tela-icon-theme
        whitesur-gtk-theme
        whitesur-icon-theme
        bibata-cursors
      ];
    })
  ];
}
