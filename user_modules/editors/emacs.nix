# inspired by:
# https://github.com/hlissner/doom-emacs
# https://gist.github.com/mjlbach/179cf58e1b6f5afcb9a99d4aaf54f549

{ inputs, config, lib, pkgs, my, ... }:

let
  cfg = config.modules.editors.emacs;
in
{
  options.modules.editors.emacs = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsNativeComp;
      extraPackages = (epkgs: [ epkgs.vterm ]);
    };

    home.packages = with pkgs; [
      ## Emacs itself
      binutils # native-comp needs 'as', provided by this

      ## Doom dependencies
      git
      (ripgrep.override { withPCRE2 = true; })
      gnutls # for TLS connectivity

      ## Optional dependencies
      fd # faster projectile indexing
      imagemagick # for image-dired
      zstd # for undo-fu-session/undo-tree compression

      emacs-all-the-icons-fonts 
    ];

    home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
  };
}
