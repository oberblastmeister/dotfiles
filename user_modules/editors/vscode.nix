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
      # ((unstable.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
      #   src = (builtins.fetchTarball {
      #     url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
      #     # sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      #     sha256 = "sha256:021z72mv9wrlpz89am3l5y57ckk4z2kwvf6bbr9zz30x1cyvqzf9";
      #   });
      #   version = "latest";

      #   buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
      # }))
    ];
  };
}
