{ inputs, options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.shell.lf;
  inherit (my.options) mkEnable;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  options.modules.shell.lf = {
    enable = mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      lf
      pistol
    ];

    modules.link.config."lf/lfrc" = "symlink";
  };
}
