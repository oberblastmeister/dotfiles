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
    fonts.packages = with pkgs; [
      ubuntu_font_family
      noto-fonts
      # for chinese to work
      noto-fonts-cjk
      noto-fonts-emoji
      roboto

      # monospace
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "CascadiaCode"
        ];
      })
      cascadia-code
    ];
  };
}
