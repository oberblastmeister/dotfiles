{ inputs, options, config, lib, my, pkgs, ... }:

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
    programs.enable = my.options.mkEnable;
  };

  config = lib.mkMerge [
    {
      programs = {
        bash = {
          enable = bashCfg.enable;
        };
        zsh = {
          enable = zshCfg.enable;
        };
        fish = {
          enable = fishCfg.enable;
        };
      };

      home.shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "1" = "cd -";
        "2" = "cd -2";
        "3" = "cd -3";
        "4" = "cd -4";
        "5" = "cd -5";
        "top" = "btm";
      };
    }

    (lib.mkIf cfg.programs.enable {
      home.packages = with pkgs; [
        bat
        exa
        fd
        ripgrep
        ripgrep-all
        tmux
        du-dust
        lf
        neofetch
        onefetch
        direnv
        xclip
        glow
        archiver
        notify-desktop
        tokei
        binutils
        zellij
        cachix
        jq
        tealdeer
        cht-sh
        shellcheck
        vivid
        moreutils
      ];

      home.sessionVariables = {
        BAT_THEME = "gruvbox-dark";
      };

      programs = {
        starship = {
          enable = true;
          settings = {
            vlang.disabled = true;
          };
        } // allIntegrations;
        fzf =
          let
            defaultOptions = [
              "--ansi"
              "--preview 'bat --style=numbers --color=always --line-range :500 --theme=gruvbox-dark {}'"
            ];
            defaultCommand = "fd --type file --color always";
          in
          {
            enable = true;
            changeDirWidgetCommand = "fd --type directory --color always";
            changeDirWidgetOptions = [
              "--ansi"
              "--preview 'exa --level 3 --tree --color always --group-directories-first --icons {} | head -50'"
            ];
            fileWidgetCommand = defaultCommand;
            fileWidgetOptions = defaultOptions;
            # inherit defaultCommand;
            # inherit defaultOptions;
            tmux.enableShellIntegration = false;
          } // allIntegrations;
        bottom.enable = true;
        direnv = {
          enable = true;
          # make nix-shell fast
          nix-direnv = {
            enable = true;
          };
        } // (builtins.removeAttrs
          allIntegrations
          # fish integration is read only and is already set by default
          [ "enableFishIntegration" ]);
        zoxide = {
          enable = true;
        } // allIntegrations;
        navi = {
          enable = true;
        } // allIntegrations;
        # enables better command-not-found
        nix-index = {
          enable = true;
        } // allIntegrations;
        dircolors = {
          enable = true;
        } // allIntegrations;
      };

      # services.lorri.enable = true;

      modules.shell.git.enable = true;
      modules.shell.tmux.enable = true;
      modules.shell.ranger.enable = true;
      modules.shell.lf.enable = true;
    })
  ];
}
