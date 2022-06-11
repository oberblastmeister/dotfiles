{ options, config, nixosConfig, lib, my, pkgs, ... }:

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

    xdg.configFile."ranger/commands.py".source = mkOutOfStoreSymlink (nixosConfig.dotfiles.naiveConfigDir + "/ranger/commands.py");
    xdg.configFile."ranger/rc.conf".source = mkOutOfStoreSymlink (nixosConfig.dotfiles.naiveConfigDir + "/ranger/rc.conf");
  };
}
