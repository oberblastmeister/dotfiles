{ options, config, lib, pkgs, unstable, ... }:

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

    # need to do this if kde is enabled
    # programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.gnome.seahorse.out}/libexec/seahorse/ssh-askpass";

    services = {
      xserver = {
        enable = true;
        # displayManager.gdm.enable = true;

        # this will enable a bunch of services and apps for us
        desktopManager.gnome.enable = true;
      };
    };
  };
}
