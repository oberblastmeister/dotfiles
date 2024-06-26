{ options, config, pkgs, unstable, lib, my, ... }:

let
  cfg = config.modules.dev.haskell;
in
{
  options.modules.dev.haskell = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # haskellPackages.ghcup
      # until cabal-3.8 is out
      cabal2nix
      cabal-install
      stack
      ghc
      haskell-language-server
      ghcid
      ormolu
      hlint
      haskellPackages.lhs2tex
      # unstable.haskellPackages.cabal-gild
      # unstable.haskell.compiler.ghc924
      # unstable.haskell-language-server # make sure this uses the same packages as ghc does, or there will be errors
      # (pkgs.writeShellScriptBin "pghci" ''
      #   cabal repl --repl-options "-interactive-print=Text.Pretty.Simple.pPrint" --build-depends pretty-simple
      # '')
      # haskell-ci
      # haskellPackages.hoogle
      # haskellPackages.stan
      # haskellPackages.ghci-dap
      # haskellPackages.haskell-debug-adapter
      # haskellPackages.haskell-dap # for stack
      # haskellPackages.threadscope
      # haskellPackages.ghcup
    ];

    home.sessionPath = [ "$HOME/.cabal/bin" "$HOME/.ghcup/bin" ];
  };
}
