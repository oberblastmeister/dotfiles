{ options, config, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.ocaml;
in
{
  options.modules.dev.ocaml = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ocaml
      dune_2
      opam
      ocamlformat
      ocamlPackages.ocaml-lsp
      ocamlPackages.utop
    ];
  };
}