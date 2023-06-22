{ config, dirs, my, lib, pkgs, unstable, inputs, ... }:

let
  cfg = config.modules.desktop.gnome;
in
{
  options.modules.desktop.gnome = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
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

    dconf.settings = {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
    };
  };
}
