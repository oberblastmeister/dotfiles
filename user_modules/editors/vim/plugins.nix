{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vim.plugins;
  inherit (lib) mkOption types;
  naiveNvimConfigDir = nixosConfig.dotfiles.naiveConfigDir + "/nvim";
  nvimConfigDir = nixosConfig.dotfiles.configDir + "/nvim";
  vscodeConfigDir = nvimConfigDir + "/vscode";
  dummyPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "dummy_plugin";
    src = ./dummy_plugin;
  };
in
{
  options.modules.editors.vim.plugins = mkOption {
    type = with types; listOf anything;
    default = [ ];
  };

  config = {
    programs.neovim.plugins =
      with pkgs.vimPlugins; [
        {
          # must be loaded first
          plugin = dummyPlugin;
          config = ''
            if exists('g:vscode')
              set noloadplugins
              set clipboard^=unnamed,unnamedplus

              " dummy config
              packadd vim-surround
              packadd targets.vim
              
              source ${vscodeConfigDir + /mappings.vim}
              
              finish
            endif
          '';
        }
        {
          plugin = packer-nvim;
          config = ''
            lua << EOF
            require('packer').init {
              luarocks = {
                python_cmd = 'python' -- Set the python command to use for running hererocks
              }
            }
            EOF
          '';
        }
        vim-surround
        {
          plugin = vim-commentary;
          config = ''
            xmap <space>c  <Plug>Commentary
            nmap <space>c  <Plug>Commentary
            omap <space>c  <Plug>Commentary
            nmap <space>cc <Plug>CommentaryLine
            nmap <space>cu <Plug>Commentary<Plug>Commentary

            noremap gc <Nop>
          '';
        }
        targets-vim
        vim-cool
        {
          plugin = gruvbox-community;
          config = ''
            colorscheme gruvbox
            let g:gruvbox_sign_column = 'bg0'
            let g:gruvbox_italic = 1
            let g:gruvbox_invert_selection = 0
          '';
        }
        vim-fugitive
        {
          plugin = gitsigns-nvim;
          config = ''
            lua << EOF
            require('gitsigns').setup {
              signs = {
                add          = {hl = 'GitGutterAdd'   , text = '┃'},
                change       = {hl = 'GitGutterChange', text = '┃'},
                delete       = {hl = 'GitGutterDelete', text = '┃'},
                topdelete    = {hl = 'GitGutterDelete', text = '┃'},
                changedelete = {hl = 'GitGutterChangeDelete', text = '┃'},
              },
              current_line_blame = true,
            }
            EOF
          '';
        }

        {
          plugin = fzf-vim;
          config = ''
            nnoremap <space>fe :nohl<CR>:Files<CR>
            nnoremap <c-f> :nohl<CR>:Rg<CR>
          '';
        }

        {
          plugin = telescope-nvim;
          config = ''
            source ${nvimConfigDir + /telescope.lua}
          '';
        }
        telescope-fzy-native-nvim
        telescope-fzf-native-nvim
      ];
  };
}
