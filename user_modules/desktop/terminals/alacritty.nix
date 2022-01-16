{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.desktop.terminals.alacritty;
  fromDir = nixosConfig.dotfiles.naiveConfigDir + "/alacritty";
  toDir = "${config.xdg.configHome}/alacritty";
  inherit (config.lib.file) mkOutOfStoreSymlink;
in

{
  options.modules.desktop.terminals.alacritty = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };

    home.file."${toDir}/alacritty.yml".source = mkOutOfStoreSymlink (fromDir + "/alacritty.yml");
  };
}
