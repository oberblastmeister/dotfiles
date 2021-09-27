{ options, config, lib, my, pkgs, ... }:

let
  bashCfg = config.modules.shell.bash;
  zshCfg = config.modules.shell.zsh;
  fishCfg = config.modules.shell.fish;
  cfg = config.modules.shell;
  inherit (lib) types mkOption mkAliasDefinitions;
  allIntegrations = {
    enableBashIntegration = bashCfg.enable;
    enableZshIntegration = zshCfg.enable;
    enableFishIntegration = fishCfg.enable;
  };
in
{
  options.modules.shell = {
    aliases = mkOption {
      default = {};
      type = types.attrsOf types.str;
    };
    programs.enable = my.options.mkEnable;
  };

  config = lib.mkMerge [
    {
      programs = {
        bash = {
          enable = bashCfg.enable;
          shellAliases = cfg.aliases;
        };
        zsh = {
          enable = zshCfg.enable;
          shellAliases = cfg.aliases;
        };
        fish = {
          enable = fishCfg.enable;
          shellAliases = cfg.aliases;
        };
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
          } // allIntegrations;
          fzf = {
            enable = true;
          } // allIntegrations;
        };

        modules.shell.git.enable = true;
      }
    )
  ];
}
