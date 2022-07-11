{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.shell.git;
in
{
  options.modules.shell.git = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases = {
      g = "git";
    };

    programs.git = {
      enable = true;
      aliases = {
        s = "status";
        a = "add";
        c = "commit";
        p = "push";
        pl = "pull";
        co = "checkout";
        d = "diff";
        rv = "remote -v";
        br = "branch";
        sw = "switch";
        spull = ''
          !git pull && git submodule sync --recursive && git submodule update --init --recursive
        '';
        supdate = ''
          !git submodule sync --recursive && git submodule update --init --recursive
        '';
      };
      userEmail = lib.mkDefault "littlebubu.shu@gmail.com";
      userName = lib.mkDefault "brian";
      extraConfig = {
        init.defaultBranch = "main";
        # rebase by default, and include merges in the rebase
        pull.rebase = "merges";
        # make it work with gnome keyring
        # this will cache the password
        # this might compile for a long time though,
        # becase we are overriding the package
        # gitFull includes libsecret
        credential.helper = "${pkgs.gitFull}/bin/git-credential-libsecret";
        merge.tool = "vimdiff";
        core.editor = "vim";
        safe.directory = [
          "/etc/dotfiles"
        ];
        status.submoduleSummary = true;
      };
    };

    programs.git.delta = {
      enable = true;
    };

    home.packages = with pkgs; [
      gh
    ];
  };
}
