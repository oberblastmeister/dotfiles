{ config, dirs, my, lib, pkgs, unstable, inputs, ... }:

let
  cfg = config.modules.editors.vscode;
in
{
  options.modules.editors.vscode = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = unstable.vscode;
    };

    # home.file."${toDir}/settings.json".source = mkOutOfStoreSymlink (naiveCodeDir + "/settings.json");
    # home.file."${toDir}/keybindings.json".source = mkOutOfStoreSymlink (naiveCodeDir + "/keybindings.json");
    # home.file."${toDir}/snippets".source = mkOutOfStoreSymlink (naiveCodeDir + "/snippets");

    home.packages = with pkgs; [
      rnix-lsp
    ];
  };
}
