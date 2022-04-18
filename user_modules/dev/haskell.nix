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
      # haskell-language-server
      cabal-install
      stack
      ghc
      ghcid
      hlint
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
