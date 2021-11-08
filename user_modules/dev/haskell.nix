{ options, config, pkgs, lib, my, ... }:

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
      haskell-language-server
      cabal-install
      stack
      ghc
      ghcid
      haskellPackages.hoogle
      haskellPackages.stan
      hlint
      haskellPackages.ghci-dap
      haskellPackages.haskell-debug-adapter
      haskellPackages.haskell-dap # for stack
      haskellPackages.threadscope
    ];

    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        haskell.haskell
      ];
    };
  };
}
