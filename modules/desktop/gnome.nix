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
        desktopManager.gnome.enable = true;
      };

      gnome.gnome-keyring.enable = true;
    };

    environment.systemPackages = with pkgs; [
      my.pop-shell
      gnome.gnome-tweaks
      orchis
      papirus-icon-theme
      dconf2nix
      gnome.dconf-editor
    ];
  };
}
