{ config, ... }:

{
  xdg.enable = true;

  # has to be in the home-manager section for some reason
  nixpkgs.config.allowUnfree = true;

  home.sessionPath = [ "~/.local/bin" ];

  fonts.fontconfig.enable = true;
}