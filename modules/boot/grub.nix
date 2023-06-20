{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.modules.boot.grub;
  inherit (lib) mkDefault;
in
{
  options.modules.boot.grub = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      version = 2;
      device = "nodev";
      useOSProber = true;
    };
  };
}
