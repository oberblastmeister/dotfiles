{ self, inputs, lib, pkgs, ... }:

let
  sys = "x86_64-linux";
in
rec {
  mk = path: attrs @ { system ? sys, ... }:
    lib.nixosSystem {
      inherit system;
      modules = [
        {
          nixpkgs.pkgs = pkgs;
          networking.hostName = lib.mkDefault (lib.removeSuffix ".nix" (baseNameOf path));
        }
        (lib.filterAttrs (n: v: !lib.elem n [ "system" ]) attrs)
        ../. # /default.nix
        (import path)
      ];
    };

  map = dir: attrs @ { system ? system, ... }:
    self.modules.map dir
      (hostPath: mk hostPath attrs);
}
