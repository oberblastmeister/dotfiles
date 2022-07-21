{ options, config, nixosConfig, lib, ... }:
let
  inherit (lib) types;
in
{
  options.modules.link = lib.mkOption {
    default = { };
    type = types.attrsOf (types.enum [ "copy" "symlink" ]);
  };

  config =
    let linkAttr = builtins.mapAttrs
      (name: value:
        let res =
          if value == "symlink"
          then config.lib.file.mkOutOfStoreSymlink (nixosConfig.dotfiles.naiveConfigDir + "/" + name)
          else if value == "copy"
          then nixosConfig.dotfiles.configDir + "/" + name
          # impossible because must be member of enum type
          else abort "impossible";
        in { source = res; }
      )
      config.modules.link;
    in
    {
      xdg.configFile = linkAttr;
    };
}
