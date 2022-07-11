{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
    (haskellPackages.ghcWithPackages (pkgs: with pkgs; [ turtle optparse-applicative unix ]))
    python310
    # we need unstable for this to fix the list bug
    python310Packages.typer
  ];
}
