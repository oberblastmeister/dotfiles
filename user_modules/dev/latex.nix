{ options, config, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.latex;
in
{
  options.modules.dev.latex = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (texlive.combine {
        inherit (texlive) scheme-medium latexmk;
      })
      tectonic
      texlab
    ];
  };
}
