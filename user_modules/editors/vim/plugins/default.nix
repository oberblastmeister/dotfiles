{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  lspconfigCfg = cfg.lspconfig.config;
  inherit (lib) mkOption types;
  naiveNvimConfigDir = nixosConfig.dotfiles.naiveConfigDir + "/nvim";
  nvimConfigDir = nixosConfig.dotfiles.configDir + "/nvim";
  vscodeConfigDir = nvimConfigDir + "/vscode";
  naiveVscodeConfigDir = naiveNvimConfigDir + "/vscode";
  dummyPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "dummy";
    src = ../dummy_plugin;
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

              packadd vim-surround
              packadd targets.vim
              
              source ${naiveVscodeConfigDir + "/mappings.vim"}
              
              finish
            endif
          '';
        }
        {
          plugin = dummyPlugin;
          config = ''
            " second dummy config
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
        vim-nix
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

        neogit

        {
          plugin = fzf-vim;
          config = ''
            nnoremap <space>fe :nohl<CR>:Files<CR>
            nnoremap <c-f> :nohl<CR>:Rg<CR>
          '';
        }

        nvim-web-devicons
        plenary-nvim

        {
          plugin = telescope-nvim;
          config = ''
            source ${nvimConfigDir + /telescope.lua}
          '';
        }
        telescope-fzy-native-nvim
        telescope-fzf-native-nvim

        {
          config = ''
            source ${nvimConfigDir + /nvim-treesitter.lua}
          '';
          plugin = (nvim-treesitter.withPlugins (
            plugins: with plugins; [
              tree-sitter-bash
              tree-sitter-c
              tree-sitter-lua
              tree-sitter-json
              tree-sitter-yaml
              tree-sitter-toml
              tree-sitter-nix
              # tree-sitter-haskell # crashes with a loop
              tree-sitter-python
              tree-sitter-ocaml
            ]
          ));
        }

        {
          config = lspconfigCfg;
          plugin = nvim-lspconfig;
        }
      ];
  };
}
