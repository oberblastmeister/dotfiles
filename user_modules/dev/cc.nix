{ config, options, lib, my, pkgs, ... }:

let
  cfg = config.modules.dev.cc;
in
{
  options.modules.dev.cc = {
    enable = my.options.mkEnable;
  };

  conifg = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      clang
      gcc
      gdb
      cmake
    ];

    programs.vscode.extensions = with pkgs; [
      vscode-extensions.ms-vscode.cpptools
    ];
  };
}
