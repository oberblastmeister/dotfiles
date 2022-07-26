{ inputs, options, config, nixosConfig, lib, my, pkgs, ... }:

let
  cfg = config.modules.shell.fish;
  inherit (my.options) mkEnable;
in
{
  options.modules.shell.fish = {
    enable = mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      shellInit = ''
        source ${nixosConfig.dotfiles.naiveConfigDir + "/fish/config.fish"}
      '';
      plugins = [
      ];
    };
    xdg.configFile."fish/functions/lfcd.fish".source = inputs.lf + "/etc/lfcd.fish";
  };
}
