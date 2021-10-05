{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.desktop.apps;
  inherit (lib) mkOption;
in
{
  imports = [
    ./flameshot.nix
  ];

  options.modules.desktop.apps.enable = my.options.mkEnable;

  config = {
    home.packages = with pkgs; [
      anki
    ];
  };
}