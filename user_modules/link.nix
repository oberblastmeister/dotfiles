{ options, config, nixosConfig, lib, ... }:
let
  inherit (lib) types;
  cfg = config.modules.link;
in
{
  options.modules.link = {
    config = lib.mkOption {
      default = { };
      type = types.attrsOf (types.enum [ "copy" "symlink" ]);
    };
    home = lib.mkOption {
      default = { };
      type = types.attrsOf (types.enum [ "copy" "symlink" ]);
    };
  };

  config =
    let
      f = name: value:
        let res =
          if value == "symlink"
          then config.lib.file.mkOutOfStoreSymlink (nixosConfig.dotfiles.naiveConfigDir + "/" + name)
          else if value == "copy"
          then nixosConfig.dotfiles.configDir + "/" + name
          # impossible because must be member of enum type
          else abort "impossible";
        in { source = res; };
      linkConfigAttr = builtins.mapAttrs f cfg.config;
      linkHomeAttr = builtins.mapAttrs f cfg.home;
    in
    {
      xdg.configFile = linkConfigAttr;
      home.file = linkHomeAttr;
    };
}
