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
        # crashes on startup for some reason
        displayManager.gdm.enable = true;

        # cannot start a Gnome wayland session
        # see https://github.com/NixOS/nixpkgs/issues/56342
        # displayManager.lightdm.enable = true;
        # displayManager.lightdm.greeters.mini = {
        #   enable = true;
        #   user = "brian";
        #   extraConfig = ''
        #     [greeter]
        #     show-password-label = true
        #     show-sys-info = true
        #     [greeter-theme]
        #     background-image = ""
        #   '';
        # };
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
      gnomeExtensions.pop-shell

      orchis
      papirus-icon-theme
      bibata-cursors
    ];
  };
}
