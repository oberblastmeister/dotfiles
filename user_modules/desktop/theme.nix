{ config, dirs, my, lib, pkgs, inputs, ... }:

{
  options.modules.desktop.theme = {
    enable = my.options.mkEnable;
  };

  config = {
    gtk = {
      enable = true;

      theme = {
        name = "Orchis-Dark";
      };

      iconTheme = {
        name = "Papirus-Dark";
      };

      cursorTheme = {
        name = "Bibata-Modern-Ice";
      };
    };

    home.packages = with pkgs; [
      flat-remix-gtk
      flat-remix-gnome
      orchis-theme
      papirus-icon-theme
      whitesur-gtk-theme
      whitesur-icon-theme
      bibata-cursors

      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
      gnomeExtensions.dash-to-panel
    ];
  };
}
