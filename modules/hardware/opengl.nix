{ config, options, pkgs, lib, ... }:

let
  cfg = config.modules.hardware.opengl;
  inherit (lib) my;
in
{
  options.modules.hardware.opengl = {
    enable = my.options.mkEnable;
    enableIntel = my.options.mkEnable;
  };

  config = lib.mkMerge [
    (
      lib.mkIf cfg.enable {
        hardware.opengl = {
          enable = true;

          # enable vulkan support
          driSupport = true;
          # For 32 bit applications
          driSupport32Bit = true;

          # extraPackages = with pkgs; [
          #   libGL
          #   vaapiVdpau
          #   libvdpau-va-gl
          # ];
        };
      }
    )

    (
      lib.mkIf cfg.enableIntel {
        hardware.opengl = {
          # extraPackages = with pkgs; [
          #   pkgs.vaapiIntel
          #   pkgs.intel-media-driver
          # ];
        };
      }
    )
  ];
}
