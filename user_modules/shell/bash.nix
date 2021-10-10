{ options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.shell.bash;
  inherit (my.options) mkEnable;
in
{
  options.modules.shell.bash = {
    enable = mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.vscode.extensions = with pkgs.vscode-extensions; [
      # mads-hartmann.bash-ide-vscode
    ];
  };
}