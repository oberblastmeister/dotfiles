{ options, config, lib, pkgs, ... }:

let
  cfg = config.modules.shell;
  inherit (lib) types mkOption mkAliasDefinitions;
in
{
  # must be used to allow home-manager to manage the shell
  options.modules.shell = {
    enable = mkOption {
      type = types.enum [ "bash" "zsh" "fish" ];
    };
    aliases = mkOption {
      default = {};
      type = types.attrsOf types.str;
    };
  };

  config = {
    programs.${cfg.enable} = {
      enable = true;
      shellAliases = mkAliasDefinitions options.modules.shell.aliases;
    };
  };
}
