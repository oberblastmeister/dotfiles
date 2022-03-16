{ nixosConfig, config, options, unstable, pkgs, lib, my, ... }:
let
  cfg = config.modules.shell.tmux;
  naiveTmuxDir = nixosConfig.dotfiles.naiveConfigDir + "/tmux";
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  options.modules.shell.tmux = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux
    ];
    
    xdg.configFile."tmux/tmux.conf".source = mkOutOfStoreSymlink (nixosConfig.dotfiles.naiveConfigDir + "/tmux/tmux.conf");
  };
}
