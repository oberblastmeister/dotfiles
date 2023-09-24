{ options, config, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.ocaml;
  # TODO: abstract this
  bashCfg = config.modules.shell.bash;
  zshCfg = config.modules.shell.zsh;
  fishCfg = config.modules.shell.fish;
  allIntegrations = {
    enableBashIntegration = bashCfg.enable;
    enableZshIntegration = zshCfg.enable;
    enableFishIntegration = fishCfg.enable;
  };
in
{
  options.modules.dev.ocaml = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      openssl
      # ocaml
      # dune_2
      # opam
      # ocamlformat
      # ocamlPackages.ocaml-lsp
      # ocamlPackages.utop
    ];

    programs.opam = {
      enable = true;
    } // allIntegrations;
  };
}
