{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.shell.git;
in
{
  options.modules.shell.git = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    modules.shell.aliases = {
      g = "git";
    };

    programs.git = {
      enable = true;
      aliases = {
        s = "status";
        a = "add";
        c = "commit";
        p = "push";
        "P" = "pull";
        co = "checkout";
      };
      userEmail = lib.mkDefault "littlebubu.shu@gmail.com";
      userName = lib.mkDefault "brian";
      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";
        # make it work with gnome keyring
        # this will cache the password
        # this might compile for a long time thought,
        # becase we are overriding the package
        credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      };
    };

    programs.git.delta = {
      enable = true;
    };

    programs.gh = {
      enable = true;
    };

    home.packages = with pkgs; [
      git-open
    ];
  };
}
