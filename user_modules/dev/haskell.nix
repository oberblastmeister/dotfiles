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
      ghcid
      unstable.haskell-language-server
      unstable.ormolu
      unstable.hlint
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
