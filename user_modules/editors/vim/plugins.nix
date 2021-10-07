{ config, nixosConfig, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.editors.vim.plugins;
  inherit (lib) mkOption types;
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
        }

        {
          plugin = telescope-nvim;
        }
        telescope-fzy-native-nvim
        telescope-fzf-native-nvim
      ];
  };
}
