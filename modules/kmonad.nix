{ inputs, pkgs, options, config, lib, ... }:
let
  cfg = config.modules.kmonad;
  inherit (lib.my.options) mkEnable;
  keyboard = { name, ... }: { };
  kmonadDir = config.dotfiles.configDir + "/kmonad";
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

    services.kmonad = {
      enable = true;
      keyboards.keychron = {
        device = "/dev/input/by-id/usb-Keychron_Keychron_Q1-if02-event-kbd";
        config = builtins.readFile (kmonadDir + "/keychron.kbd");
      };
    };
  };
}
