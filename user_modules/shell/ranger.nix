{ options, config, dirs, lib, my, pkgs, ... }:

let
  cfg = config.modules.shell.ranger;
  inherit (my.options) mkEnable;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  options.modules.shell.ranger = {
    enable = mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ranger
    ];

    xdg.configFile."ranger/commands.py".source = mkOutOfStoreSymlink (dirs.naiveConfigDir + "/ranger/commands.py");
    xdg.configFile."ranger/rc.conf".source = mkOutOfStoreSymlink (dirs.naiveConfigDir + "/ranger/rc.conf");
  };
}
