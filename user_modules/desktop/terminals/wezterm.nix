{ config, dirs, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.desktop.terminals.wezterm;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  options.modules.desktop.terminals.wezterm = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.file."${config.xdg.configHome}/wezterm/wezterm.lua".source = mkOutOfStoreSymlink (dirs.naiveConfigDir + "/wezterm/wezterm.lua");
  };
}

