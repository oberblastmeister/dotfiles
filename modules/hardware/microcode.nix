{ options, config, lib, pkgs, ... }:

let
  inherit (lib) my;
  cfg = config.modules.hardware.microcode;
in
{
  options.modules.hardware.microcode = {
    amd.enable = my.options.mkEnable;
    intel.enable = my.options.mkEnable;
  };

  config = with pkgs; lib.mkMerge [
    ({
      warnings =
        if !cfg.amd.enable && !cfg.intel.enable
        then [ "You should enable microcode to ensure system stability" ]
        else [ ];
    })

    (lib.mkIf cfg.amd.enable {
      environment.systemPackages = [
        microcodeAmd
      ];
    })

    (lib.mkIf cfg.intel.enable {
      environment.systemPackages = [
        microcodeIntel
      ];
    })
  ];
}
