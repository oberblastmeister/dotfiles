{ config, nixosConfig, my, lib, pkgs, unstable, inputs, ... }:

let
  cfg = config.modules.editors.vscode;
  naiveCodeDir = nixosConfig.dotfiles.naiveConfigDir + "/Code";
  toDir = "${config.xdg.configHome}/Code/User";
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  jsonFormat = pkgs.formats.json { };
in
{
  options.modules.editors.vscode = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      # breaks sometimes
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        arrterian.nix-env-selector
        asvetliakov.vscode-neovim
        bodil.file-browser
        eamodio.gitlens
        kahole.magit
        streetsidesoftware.code-spell-checker
        vspacecode.whichkey
      ];
    };

    home.file."${toDir}/settings.json".source = mkOutOfStoreSymlink (naiveCodeDir + "/settings.json");
    home.file."${toDir}/keybindings.json".source = mkOutOfStoreSymlink (naiveCodeDir + "/keybindings.json");
    
    home.packages = with pkgs; [
      rnix-lsp
    ];
  };
}
