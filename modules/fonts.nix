{ config, pkgs, lib, ... }:

let
  cfg = config.modules.fonts;
  inherit (lib) my;
in
{
  options.modules.fonts = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    fonts.fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];
  };
}
