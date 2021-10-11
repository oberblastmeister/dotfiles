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
    boot.loader = {
      efi = {
        canTouchEfiVariables = mkDefault true;
      };
      grub = {
        enable = true;
        # only support efi
        device = mkDefault "nodev";
        efiSupport = mkDefault true;
        useOSProber = mkDefault true;
      };
    };
  };
}
