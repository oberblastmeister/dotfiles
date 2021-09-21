{ self, lib, ... }:

let
  inherit (lib) mkOption types;
in

{
  mkBool = mkOption {
    default = false;
    type = types.bool;
    example = true;
  };
}
