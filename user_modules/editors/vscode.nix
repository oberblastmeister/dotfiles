{ config, config', my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vscode;
  codeDir = config'.dotfiles.configDir + "/Code";
  toDir = "${config.xdg.configHome}/Code/User";
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
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

    # home.file."$[toDir/settings.json".source = config.lib.file.mkOutOfStoreSymlink (../../config/)
    # home.file."${toDir}/settings.json".source = config.lib.file.mkOutOfStoreSymlink (codeDir + "/settings.json");
    # home.file."${toDir}/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink (codeDir + "/keybindings.json");

    # home.file."${toDir}/settings.json".source = codeDir + "/settings.json";
    # home.file."${toDir}/keybindings.json".source = codeDir + "/keybindings.json";
    # home.file."test.md".source = config'.dotfiles.configDir + "/test.md";
    home.file."test.md".source = config.lib.file.mkOutOfStoreSymlink (config'.dotfiles.configDir + "/test.md");
  };
}
