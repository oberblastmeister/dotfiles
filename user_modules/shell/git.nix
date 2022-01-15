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
      };
      userEmail = lib.mkDefault "littlebubu.shu@gmail.com";
      userName = lib.mkDefault "brian";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false; # merge (the default strategy)
        # make it work with gnome keyring
        # this will cache the password
        # this might compile for a long time though,
        # becase we are overriding the package
        credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      };
    };

    programs.git.delta = {
      enable = true;
    };

    home.packages = with pkgs; [
      gh
      git-open
    ];
  };
}
