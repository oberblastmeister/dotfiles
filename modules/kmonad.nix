{ inputs, pkgs, options, config, lib, ... }:
let
  cfg = config.modules.kmonad;
  inherit (lib.my.options) mkEnable;
  keyboard = { name, ... }: {

  };
in
{
  imports = [ inputs.kmonad.nixosModules.default ];

  options.modules.kmonad = {
    enable = mkEnable;
  };
  
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kmonad
    ];
  };
}
