{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  naiveNvimConfigDir = nixosConfig.dotfiles.naiveConfigDir + "/nvim";
  nvimConfigDir = nixosConfig.dotfiles.configDir + "/nvim";
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

    modules.editors.vim = {
      vscodeExtraConfig = ''
        packadd vim-surround
        packadd targets.vim
        
        ${builtins.readFile (nvimConfigDir + /vscode_mappings.vim)}
      '';
      
      extraConfig = ''
        source ${nvimConfigDir + /settings.vim}
      '';
    };

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
        {
          plugin = gruvbox-community;
          config = ''
            colorscheme gruvbox
            let g:gruvbox_sign_column = 'bg0'
            let g:gruvbox_italic = 1
            let g:gruvbox_invert_selection = 0
          '';
        }
      ];
      extraConfig = ''
        if exists('g:vscode')
          set noloadplugins
          set clipboard^=unnamed,unnamedplus

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
