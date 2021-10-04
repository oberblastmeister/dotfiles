{ config, config', my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vscode;
  naiveCodeDir = config'.dotfiles.naiveConfigDir + "/Code";
  toDir = "${config.xdg.configHome}/Code/User";
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  iniFormat = pkgs.formats.ini { };
  jsonFormat = pkgs.formats.json { };
  configDir = config.xdg.configHome;
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
    };

    home.file."${toDir}/settings.json".source = mkOutOfStoreSymlink (naiveCodeDir + "/settings.json");
    home.file."${toDir}/keybindings.json".source = mkOutOfStoreSymlink (naiveCodeDir + "/keybindings.json");
    home.file."test.md".source = ./test.md;
  };


  # home.file."test.ini" = /* mkIf (cfg.settings != { }) */ {
  #   source = jsonFormat.generate "flameshot.ini" {
  #     General = {
  #       contrastUiColor = "#458588";
  #       uiColor = "#83a598";
  #       drawColor = "#8ec07c";
  #       disabledTrayIcon = false;
  #       drawThickness = 2;
  #       # saveAfterCopyPath=/home/brian/Pictures
  #       # savePath=/home/brian/Pictures
  #       # savePathFixed=false;
  #       # setSaveAsFileExtension=Portable Network Graphic file (PNG) (*.png)
  #       showHelp = false;
  #       showSidePanelButton = false;
  #       showStartupLaunchMessage = false;
  #     };
  #   };
  # };
}
