{ options, config, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.python;
in
{
  options.modules.dev.python = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rye
      # python310
      # black
      # python39Packages.pip
      # python39Packages.ipython
      # python39Packages.setuptools
      # python39Packages.pylint
      # python39Packages.poetry
    ];

    home.sessionPath = [ "$HOME/.rye/shims" ];
  };
}
