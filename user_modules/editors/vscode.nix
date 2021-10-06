{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

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

    # home.file."test.md".source = ./test.md;
    # home.file."generated.json".source = jsonFormat.generate "generated.json" {
    #   hello = "world";
    # };
  };
}