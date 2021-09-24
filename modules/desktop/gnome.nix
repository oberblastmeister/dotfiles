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
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };

      gnome.gnome-keyring.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      orchis
    ];
  };
}
