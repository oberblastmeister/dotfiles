args@{ pkgs, ... }:

let
  cfg = args.config.modules.desktop.kde;
  inherit (args) lib;
in
{
  options.modules.desktop.kde = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver.displayManager.defaultSession = "plasmawayland";

    # programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.gnome.seahorse.out}/libexec/seahorse/ssh-askpass";
    # programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass}/bin/ksshaskpass";

    # this still needs to be enabled, better allows running gnome apps outside of gnome
    # apply gtk themes, etc
    programs.dconf.enable = true;

  };
}
