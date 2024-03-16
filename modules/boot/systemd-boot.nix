{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.modules.boot.systemd-boot;
  inherit (lib) mkDefault;
in
{
  options.modules.boot.systemd-boot = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = mkDefault 15;
    };
  };
}
