{ config, lib, ... }:
let
  cfg = config.modules.kanata;
  inherit (lib.my.options) mkEnable;
in
{
  options.modules.kanata ={
    enable = mkEnable;
  };

  config = lib.mkIf cfg.enable {
    services.kanata = {
      enable = true;
      keyboards.laptop = {
        devices = [ "/dev/input/by-id/usb-ASUSTeK_Computer_Inc._N-KEY_Device-if02-event-kbd" ];
        # devices = [ ];
        config = builtins.readFile ./kanata.kbd;
      };
    };
  };
}
