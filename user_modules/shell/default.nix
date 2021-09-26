{ options, config, lib, my, pkgs, ... }:

let
  cfg = config.modules.shell;
  inherit (lib) types mkOption mkAliasDefinitions;

  shells = [ "bash" "zsh" "fish" ];

  integrationMap = {
    bash = "enableBashIntegration";
    zsh = "enableZshIntegration";
    fish = "enableFishIntegration";
  };

  cfgIntegration = integrationMap.${cfg.enable};
in
{
  # must be used to allow home-manager to manage the shell
  options.modules.shell = {
    enable = mkOption {
      type = types.enum shells;
    };
    aliases = mkOption {
      default = {};
      type = types.attrsOf types.str;
    };
    programs.enable = my.options.mkEnable;
  };

  config = lib.mkMerge [
    {
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
    }

    (
      lib.mkIf cfg.programs.enable {

        home.packages = with pkgs; [
          bat
          exa
          fd
          fzf
          ripgrep
          ripgrep-all
          tmux
          du-dust
          lf
          neofetch
          onefetch
          direnv
          bottom-rs
          zoxide
          xclip
          glow
          archiver
          notify-desktop
        ];

        programs = {
          starship = {
            enable = true;
            ${cfgIntegration} = true;
          };
          fzf = {
            enable = true;
            ${cfgIntegration} = true;
          };
        };
        
        modules.shell.git.enable = true;
      }
    )
  ];
}