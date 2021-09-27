{ config, config', my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vscode;
  codeDir = config'.dotfiles.realConfigDir + "/Code";
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
        arrterian.nix-env-selector
        asvetliakov.vscode-neovim
        bodil.file-browser
        eamodio.gitlens
        kahole.magit
        streetsidesoftware.code-spell-checker
      ];
      # userSettings = builtins.fromJSON (builtins.readFile (codeDir + "/settings.json"));
      # keybindings = builtins.fromJSON (builtins.readFile (codeDir + "/keybindings.json"));
    };
  };
}
