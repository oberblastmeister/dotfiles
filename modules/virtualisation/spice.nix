{ options, config, lib, pkgs, ... }:

let
  cfg = config.modules.virtualisation.spice;
in
{
  options.modules.virtualisation.spice = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    services.spice-vdagentd.enable = true;
  };
}