{ config, pkgs, lib, my, ... }:

let
  cfg = config.modules.fonts;
in
{
  options.modules.fonts = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      ubuntu_font_family
      noto-fonts
      # for chinese to work
      noto-fonts-cjk
      noto-fonts-emoji
      roboto

      arphic-ukai

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
