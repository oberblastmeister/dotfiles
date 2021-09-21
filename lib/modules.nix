{ self, lib, ... }:

rec {
  map = dir: fn:
    self.attrs.mapFilter
      (n: v: v != null && !(lib.hasPrefix "_" n))
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
  mapRec' = dir: fn:
    let
      dirs =
        lib.mapAttrsToList
          (k: _: "${dir}/${k}")
          (
            lib.filterAttrs
              (n: v: v == "directory" && !(lib.hasPrefix "_" n))
              (builtins.readDir dir)
          );
      files = builtins.attrValues (self.modules.map dir lib.id);
      paths = files ++ builtins.concatLists (map (d: mapRec' d lib.id) dirs);
    in
      map fn paths;
}
