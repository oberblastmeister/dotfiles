{ config, dirs, my, lib, pkgs, unstable, very-unstable, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  inherit (lib) mkOption types;
  naiveNvimConfigDir = dirs.naiveConfigDir + "/nvim";
  nvimConfigDir = dirs.configDir + "/nvim";
  nvimMappingsDir = nvimConfigDir + "/mappings";
  vscodeConfigDir = nvimConfigDir + "/vscode";
  naiveVscodeConfigDir = naiveNvimConfigDir + "/vscode";
  dummyPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "dummy";
    src = ../dummy_plugin;
  };
  plugins =
    with unstable.vimPlugins; [
      # the dummy plugin must be loaded first because we want the vscode stuff to take over
      {
        plugin = dummyPlugin;
        config = ''
          if exists('g:vscode')
            set noloadplugins
            set clipboard^=unnamed,unnamedplus

            packadd vim-surround

            source ${naiveVscodeConfigDir + "/mappings.vim"}
            
            finish
          endif
        '';
      }

      {
        plugin = dummyPlugin;
        config = ''
          source ${naiveNvimConfigDir + "/user_init.lua"}

          " settings
          source ${nvimConfigDir + /settings.vim}
          
          " mappings
          source ${nvimMappingsDir + /normal.vim}
          source ${nvimMappingsDir + /leader.vim}
          source ${nvimMappingsDir + /visual.vim}
          source ${nvimMappingsDir + /insert.vim}
        '';
      }

      vim-nix
      vim-surround

      # sexp stuff
      vim-sexp
      vim-sexp-mappings-for-regular-people
      conjure
      # TODO: this is slowing down startup time 

      {
        plugin = parinfer-rust;
        optional = true;
        config = ''
          source ${naiveNvimConfigDir + "/parinfer.lua"}
        '';
      }

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

          source ${naiveNvimConfigDir + "/gruvbox.lua"}
        '';
      }

      vim-fugitive

      {
        plugin = gitsigns-nvim;
        # config = ''
        #   lua << EOF
        #   require('gitsigns').setup {
        #     signs = {
        #       add          = {hl = 'GitGutterAdd'   , text = '┃'},
        #       change       = {hl = 'GitGutterChange', text = '┃'},
        #       delete       = {hl = 'GitGutterDelete', text = '┃'},
        #       topdelete    = {hl = 'GitGutterDelete', text = '┃'},
        #       changedelete = {hl = 'GitGutterChangeDelete', text = '┃'},
        #     },
        #     current_line_blame = true,
        #   }
        #   EOF
        # '';
      }

      {
        plugin = neogit;
        config = ''
          nnoremap <leader>gs <cmd>Neogit<CR>
        '';
      }

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
          source ${naiveNvimConfigDir + "/telescope.lua"}
        '';
      }
      telescope-fzy-native-nvim
      telescope-fzf-native-nvim
      telescope-file-browser-nvim

      # vim-polyglot
      {
        config = ''
        '';
        plugin = nvim-treesitter.withAllGrammars;
      }
      nvim-treesitter-refactor
      playground

      {
        config = cfg.lspconfig.config;
        plugin = nvim-lspconfig;
      }

      # {
      #   plugin = nvim-cmp;
      #   config = ''
      #     source ${naiveNvimConfigDir + "/cmp.lua"}
      #   '';
      # }
      # cmp-nvim-lsp
      # cmp-buffer
      # {
      #   plugin = luasnip;
      #   config = ''
      #     source ${naiveNvimConfigDir + "/luasnip.vim"}
      #   '';
      # }
      # cmp_luasnip
      # cmp-cmdline
      # lspkind-nvim # nice icons for completion

      pkgs.vimPlugins.coq_nvim
      pkgs.vimPlugins.coq-artifacts
      nvim-autopairs

      {
        plugin = lspsaga-nvim;
        config = ''
          source ${naiveNvimConfigDir + "/lspsaga.lua"}
        '';
      }

      {
        plugin = haskell-vim;
        config = ''
          lua << EOF
          vim.g.haskell_indent_if = 2
          vim.g.haskell_indent_before_where = 2
          vim.g.haskell_indent_case = 2
          vim.g.haskell_indent_let = 2
          vim.g.haskell_indent_where = 2
          vim.g.haskell_indent_after_bare_where = 2
          vim.g.haskell_indent_do = 2
          vim.g.haskell_indent_in = 1
          vim.g.haskell_indent_guard = 2
          vim.g.haskell_indent_case_alternative = 2

          vim.g.haskell_enable_quantification = 1   -- to enable highlighting of `forall`
          vim.g.haskell_enable_recursivedo = 1      -- to enable highlighting of `mdo` and `rec`
          vim.g.haskell_enable_arrowsyntax = 1      -- to enable highlighting of `proc`
          vim.g.haskell_enable_pattern_synonyms = 1 -- to enable highlighting of `pattern`
          vim.g.haskell_enable_typeroles = 1        -- to enable highlighting of type roles
          vim.g.haskell_enable_static_pointers = 1  -- to enable highlighting of `static`
          vim.g.haskell_backpack = 1                -- to enable highlighting of backpack keywords
          EOF
        '';
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "dirbuf";
          src = inputs.dirbuf;
        };
        config = ''
          source ${naiveNvimConfigDir + "/dirbuf.lua"}
        '';
      }

      nvim-colorizer-lua

      neodev-nvim
    ];
in
{
  options.modules.editors.vim.plugins = mkOption {
    type = with types; listOf anything;
    default = [ ];
  };

  config = {
    programs.neovim.plugins = plugins;
  };
}
