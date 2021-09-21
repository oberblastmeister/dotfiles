{ self, lib, ... }:

rec {
  get = dir:
    self.attrs.mapFilter
      (n: v: v != null && !(lib.hasPrefix "_" n))
      (
        n: v:
          let
            path = "${toString dir}/${n}";
          in
            if v == "directory" && builtins.pathExists "${path}/default.nix"
            then lib.nameValuePair n path
            else if v == "regular" && n != "default.nix" && lib.hasSuffix ".nix" n
            then lib.nameValuePair (lib.removeSuffix ".nix" n) path
            else lib.nameValuePair "" null
      )
      (builtins.readDir dir);

  map = dir: fn: builtins.mapAttrs (_: fn) (get dir);

  # mapModulesRec with tree structure
  mapRec = dir: fn:
    self.attrs.mapFilter
      (n: v: v != null && !(lib.hasPrefix "_" n))
      (
        n: v:
          let
            path = "${toString dir}/${n}";
          in
            if v == "directory"
            then lib.nameValuePair n (mapRec path fn)
            else if v == "regular" && n != "default.nix" && lib.hasSuffix ".nix" n
            then lib.nameValuePair (lib.removeSuffix ".nix" n) (fn path)
            else lib.nameValuePair "" null
      )
      (builtins.readDir dir);

  # mapModulesRec but with flattened structure into a list
  getRec' = dir:
    let
      dirs =
        lib.mapAttrsToList
          # dir must stay a path and not be converted to a string
          # using "${dir}" or the path will not be found
          (k: _: dir + "/${k}")
          (
            lib.filterAttrs
              (n: v: v == "directory" && !(lib.hasPrefix "_" n))
              (builtins.readDir dir)
          );
      files = builtins.attrValues (get dir);
      paths = files ++ builtins.concatLists (builtins.map getRec' dirs);
    in
      paths;

  mapRec' = dir: fn: builtins.map fn (getRec' dir);

  importAll = dir: self.modules.map dir import;

  importAllRec' = dir: self.modules.mapRec' dir import;

  mapModules = dir: fn:
    self.attrs.mapFilter
      (
        n: v:
          v != null && !(lib.hasPrefix "_" n)
      )
      (
        n: v:
          let
            path = "${toString dir}/${n}";
          in
            if v == "directory" && builtins.pathExists "${path}/default.nix"
            then lib.nameValuePair n (fn path)
            else if v == "regular" && n != "default.nix" && lib.hasSuffix ".nix" n
            then lib.nameValuePair (lib.removeSuffix ".nix" n) (fn path)
            else lib.nameValuePair "" null
      )
      (builtins.readDir dir);

  mapModulesRec' = dir: fn:
    let
      dirs =
        lib.mapAttrsToList
          (k: _: "${dir}/${k}")
          (
            lib.filterAttrs
              (n: v: v == "directory" && !(lib.hasPrefix "_" n))
              (builtins.readDir dir)
          );
      files = builtins.attrValues (mapModules dir lib.id);
      paths = files ++ builtins.concatLists (builtins.map (d: mapModulesRec' d lib.id) dirs);
    in
      builtins.map fn paths;
}
