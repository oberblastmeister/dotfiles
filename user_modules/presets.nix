{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.presets;
  inherit (lib) types mkOption mkDefault;

  fullPreset = {
    modules = {
      editors = {
        vim.enable = mkDefault true;
        vscode.enable = mkDefault true;
        emacs.enable = mkDefault true;
      };
      dev = {
        rust.enable = mkDefault true;
        haskell.enable = mkDefault true;
        idris.enable = mkDefault true;
        agda.enable = mkDefault true;
        ocaml.enable = mkDefault true;
        coq.enable = mkDefault true;
        python.enable = mkDefault true;
        cc.enable = mkDefault true;
        markdown.enable = mkDefault true;
        racket.enable = mkDefault true;
        javascript.enable = mkDefault true;
        # java.enable = mkDefault true;
        # latex.enable = mkDefault true;
      };
      shell = {
        fish.enable = mkDefault true;
        bash.enable = mkDefault false;
        programs.enable = mkDefault true;
      };
      desktop = {
        terminals.alacritty.enable = mkDefault true;
        apps = {
          enableAll = mkDefault true;
        };
      };
    };
  };

  minimalPreset = {
    modules = {
      editors = {
        vim.enable = mkDefault true;
        vscode.enable = mkDefault true;
      };
      shell = {
        fish.enable = mkDefault true;
        programs.enable = mkDefault true;
      };
      desktop = {
        browsers.firefox.enable = mkDefault true;
        terminals.gnome-terminal.enable = mkDefault true;
      };
    };
  };
in

{
  options.modules.presets.enable = mkOption {
    default = null;
    type = types.nullOr (types.enum [ "full" "minimal" ]);
  };

  config = lib.mkIf (cfg.enable != null) (
    lib.mkMerge [
      (lib.mkIf (cfg.enable == "full") fullPreset)
      (lib.mkIf (cfg.enable == "minimal") minimalPreset)
    ]
  );
}
