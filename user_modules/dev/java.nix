{ options, config, unstable, pkgs, lib, my, ... }:
let
  cfg = config.modules.dev.java;
in
{
  options.modules.dev.java = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      jdk
      gradle
    ];

    programs.vscode.extensions = with pkgs.vscode-extensions; [
      redhat.java
    ];
  };
}
