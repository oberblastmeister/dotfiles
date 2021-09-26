{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.shell.git;
in
{
  options.modules.shell.git = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      aliases = {
        s = "status";
        a = "add";
        c = "commit";
        p = "push";
        P = "pull";
        co = "checkout";
      };
      userEmail = lib.mkDefault "littlebubu.shu@gmail.com";
      userName = lib.mkDefault "brian";
      extraConfig = {
        pull = {
          rebase = true;
          init.defaultBranch = "main";
        };
      };
    };

    programs.delta = {
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
