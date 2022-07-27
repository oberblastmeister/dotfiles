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
      cabal2nix
      cabal-install
      stack
      # ghc
      unstable.haskell.compiler.ghc923
      unstable.haskell-language-server # make sure this uses the same packages as ghc does, or there will be errors
      ghcid
      ormolu
      hlint
      (pkgs.writeShellScriptBin "pghci" ''
        cabal repl --repl-options "-interactive-print=Text.Pretty.Simple.pPrint" --build-depends pretty-simple
      '')
      haskell-ci
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
