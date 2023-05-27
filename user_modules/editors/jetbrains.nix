{ config, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.jetbrains;
  inherit (my.options) mkEnable;
in
{
  options.modules.editors.jetbrains = {
    intellij = {
      enable = mkEnable;
      enableUltimate = mkEnable;
    };
    pycharm = {
      enable = mkEnable;
      enableProfessional = mkEnable;
    };
    clion = {
      enable = mkEnable;
    };
  };

  config = with pkgs.jetbrains; lib.mkMerge [
    (lib.mkIf cfg.intellij.enable {
      home.packages = [ idea-community ];
    })
    (lib.mkIf cfg.intellij.enableUltimate {
      home.packages = [ idea-ultimate ];
    })
    (lib.mkIf cfg.pycharm.enable {
      home.packages = [ pycharm-community ];
    })
    (lib.mkIf cfg.pycharm.enableProfessional {
      home.packages = [ pycharm-professional ];
    })
    (lib.mkIf cfg.clion.enable {
      home.packages = [ clion ];
    })
  ];
}
