{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  options.modules.editors.vim = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-surround
        {
          plugin = vim-commentary;
          config = ''
            xmap <Leader>c  <Plug>Commentary
            nmap <Leader>c  <Plug>Commentary
            omap <Leader>c  <Plug>Commentary
            nmap <Leader>cc <Plug>CommentaryLine
            nmap <Leader>cu <Plug>Commentary<Plug>Commentary

            noremap gc <Nop>
          '';
        }
        targets-vim
      ];
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraConfig = ''
      '';
    };

    xdg.configFile = {
      # a copy of init.vim in fact
      "nvim/init.generated.vim".text = config.programs.neovim.generatedConfigViml;
    };
    # modules.shell.aliases = {
    #   "vim" = "nvim";
    #   "vi" = "nvim";
    # };

    # xdg.configFile = {
    #   "nvim".source = mkOutOfStoreSymlink (nixosConfig.dotfiles.naiveConfigDir + "/nvim");
    # };
  };
}
