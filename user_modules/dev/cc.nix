{ config, options, lib, my, pkgs, ... }:

let
  cfg = config.modules.dev.cc;
in
{
  options.modules.dev.cc = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      clang
      clang-tools
      # note: gcc has a conflict with nix for some reason
      gdb
      cmake
    ];

    # use clangd instead of microsoft c/cpp, its much better
    programs.vscode.extensions = with pkgs; [ ];
  };
}
