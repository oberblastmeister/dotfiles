{ options, config, lib, pkgs, ... }:

let
  cfg = config.modules.shell;
  inherit (lib) types mkOption;
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
      example = literalExample ''
        {
          ll = "ls -l";
          ".." = "cd ..";
        }
      '';
      description = ''
        An attribute set that maps aliases (the top level attribute names in
        this option) to command strings or directly to build outputs.
      '';
    };
  };

  config = {
    programs.${cfg.enable}.enable = true;
    programs.${cfg.enable}.shellAliases = config.modules.shell.aliases;
  };
}
