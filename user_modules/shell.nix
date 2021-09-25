{ options, config, lib, pkgs, ... }:

let
  cfg = config.modules.shell;
  inherit (lib) types mkOption;
in
{
  options.modules.shell.enable = mkOption {
    type = (types.enum [ "bash" "zsh" "fish" ]);
  };

  config = {
    warnings =
      if config.modules.shell.enable == null
      then [
        ''
          You must select a shell for `modules.shell.enable` because home-manager needs to manage the shell
          for things like `sessionVariables` and `shellAliases` to work.
        ''
      ]
      else [];
    programs.${cfg.enable}.enable = true;
  };
}
