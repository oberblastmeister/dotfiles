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

    modules.shell.aliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "1" = "cd -";
      "2" = "cd -2";
      "3" = "cd -3";
      "4" = "cd -4";
      "5" = "cd -5";
    };
  };
}
