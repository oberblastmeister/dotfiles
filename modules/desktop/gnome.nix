{ options, config, lib, pkgs, ... }:

let
  cfg = config.modules.desktop.gnome;
  inherit (lib) mkOption;
in
{
  options.modules.desktop.gnome = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;

    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        # this will enable a bunch of services and apps for us
        desktopManager.gnome.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnome.dconf-editor
      dconf2nix

      gnomeExtensions.clipboard-indicator
      gnomeExtensions.appindicator

      orchis
      papirus-icon-theme
    ];
  };
}
