args:

let
  cfg = args.config.modules.desktop.kde;
  inherit (args) lib;
in
{
  options.modules.desktop.kde = {
    enable = lib.my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver.displayManager.defaultSession = "plasmawayland";
  };
}
