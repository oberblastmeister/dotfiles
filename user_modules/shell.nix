{ options, config, lib, pkgs, ... }:

let
  cfg = config.modules.shell;
  inherit (lib) mkOption;
in
{
  options.modules.shell.enable = mkOption {
    type = types.nullOr (types.enum [ "bash" "zsh" "fish" ]);
  };
}
