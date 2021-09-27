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
      python310
      python39Packages.pip
      python39Packages.ipython
      python39Packages.black
      python39Packages.setuptools
      python39Packages.pylint
      python39Packages.poetry
    ];

    programs.vscode.extensions = with pkgs; [
      # fails for some reason
      # vscode-extensions.ms-python.python
      ms-python.vscode-pylance
    ];
  };
}
