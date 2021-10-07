{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  options.modules.editors.vim = {
    enable = my.options.mkEnable;
    vscodeExtraConfig = mkOption {
      type = types.str;
      default = "";
    };
    extraConfig = mkOption {
      type = types.str;
      default = "";
    };
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
            xmap <Space>c  <Plug>Commentary
            nmap <Space>c  <Plug>Commentary
            omap <Space>c  <Plug>Commentary
            nmap <Space>cc <Plug>CommentaryLine
            nmap <Space>cu <Plug>Commentary<Plug>Commentary

            noremap gc <Nop>
          '';
        }
        targets-vim
      ];
      extraConfig = ''
        if exists('g:vscode')
          ${cfg.vscodeExtraConfig}
          
          finish
        endif
        
        ${cfg.extraConfig}
      '';
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
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
