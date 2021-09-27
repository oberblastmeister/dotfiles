{ lib, ... }:

let
  inherit (lib) mkOption types;
in

{
  mkOpt = type: default:
    mkOption { inherit type default; };

  mkEnable = mkOption {
    default = false;
    type = types.bool;
    example = true;
  };
}
