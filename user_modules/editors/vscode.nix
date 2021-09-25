{ config, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vscode;
  inherit (lib) mkOption types;
in
{
  options.modules.editors.vscode = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        vscodevim.vim
        bodil.file-browser
        eamodio.gitlens
        kahole.magit
        streetsidesoftware.code-spell-checker
      ];
    };
  };
}
