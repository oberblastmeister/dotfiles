{ config, lib, ... }:
let
  cfg = config.modules.presets;
  inherit (lib) types mkOption mkDefault;

  fullPreset = {
    modules = {
      kmonad.enable = mkDefault true;
      desktop.gnome.enable = mkDefault true;
    };
  };

  minimalPreset = { };
in
{
  options.modules.presets.enable = mkOption {
    default = null;
    type = with types; nullOr (enum [ "full" "minimal" ]);
  };

  config = lib.mkIf (cfg.enable != null) (
    lib.mkMerge [
      (lib.mkIf (cfg.enable == "full") fullPreset)
      (lib.mkIf (cfg.enable == "minimal") minimalPreset)
    ]
  );
}
