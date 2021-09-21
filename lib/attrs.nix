{ lib, ... }:

let
  inherit (lib) filterAttrs mapAttrs';
in
rec {
  # mapFilterAttrs ::
  #   (name -> value -> bool)
  #   (name -> value -> { name = any; value = any; })
  #   attrs
  mapFilter = pred: f: attrs: filterAttrs pred (mapAttrs' f attrs);
}
