{ config, dirs, my, lib, pkgs, unstable, inputs, ... }:

{
  options.modules.desktop.gnome = {
    enable = my.options.mkEnable;
  };

  config = {
    home.packages = with pkgs; [
      gnome.gnome-tweaks
      gnome.dconf-editor
      xfce.thunar
      dconf2nix

      gnomeExtensions.appindicator
      # sometimes stuff doesn't get tiled
      unstable.gnomeExtensions.pop-shell
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
      gnomeExtensions.dash-to-panel
    ];
  };
}
