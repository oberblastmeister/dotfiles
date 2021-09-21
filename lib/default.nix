{ inputs, lib, pkgs, ... }:

lib.makeExtensible (
  self:
    let
      args = { inherit self lib pkgs inputs; };
    in
      {
        modules = import ./modules.nix args;
        attrs = import ./attrs.nix args;
        hosts = import ./hosts.nix args;
        options = import ./options.nix args;
      }
)
