{ options, config, dirs, lib, ... }:
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
          then config.lib.file.mkOutOfStoreSymlink (dirs.naiveConfigDir + "/" + name)
          else if value == "copy"
          then dirs.configDir + ("/" + name) # weird parenthesis to make sure slash is on name first
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
