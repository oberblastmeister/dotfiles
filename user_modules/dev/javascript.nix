# https://matthewrhone.dev/nixos-npm-globally
{ options, config, pkgs, unstable, lib, my, ... }:
let
  cfg = config.modules.dev.javascript;
in
{
  options.modules.dev.javascript = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs
      nodePackages.npm
      nodePackages.typescript
      nodePackages.node2nix
    ];

    home.sessionPath = [ "$HOME/.npm-packages/bin" ];

    modules.link.home.".npmrc" = "symlink";
  };
}
