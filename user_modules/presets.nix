{ config, options, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.presets;
  inherit (lib) types mkOption mkDefault;

  fullPreset = {
    modules = {
      editors = {
        vim.enable = mkDefault true;
        vscode.enable = mkDefault true;
      };
      dev = {
        python.enable = mkDefault true;
        rust.enable = mkDefault true;
        haskell.enable = mkDefault true;
        cc.enable = mkDefault true;
      };
      shell = {
        enable = mkDefault "fish";
        programs.enable = mkDefault true;
      };
      desktop = {
        browsers.firefox.enable = mkDefault true;
      };
    };
  };

  minimalPreset = {};
in

{
  options.modules.presets.enable = mkOption {
    type = types.nullOr (types.enum [ "full" "minimal" ]);
  };

  config = lib.mkIf (cfg.enable != null) (
    lib.mkMerge [
      (lib.mkIf (cfg.enable == "full") fullPreset)
      (lib.mkIf (cfg.enable == "minimal") minimalPreset)
    ]
  );
}
