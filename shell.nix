{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    rnix-lsp
    nixpkgs-fmt
    python310
    python39Packages.pylint
    python39Packages.autopep8
    python39Packages.rope
  ];
}
