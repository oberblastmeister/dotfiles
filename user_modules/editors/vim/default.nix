{ config, dirs, my, lib, pkgs, unstable, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  naiveNvimConfigDir = dirs.naiveConfigDir + "/nvim";
  nvimConfigDir = dirs.configDir + /nvim;
  nvimMappingsDir = nvimConfigDir + /mappings;
in
{
  options.modules.editors.vim = {
    enable = my.options.mkEnable;
    extraConfig = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    modules.editors.vim = {
      extraConfig = ''
        source ${naiveNvimConfigDir + "/user_init.lua"}

        " settings
        source ${nvimConfigDir + /settings.vim}
        
        " mappings
        source ${nvimMappingsDir + /normal.vim}
        source ${nvimMappingsDir + /leader.vim}
        source ${nvimMappingsDir + /visual.vim}
        source ${nvimMappingsDir + /insert.vim}
        
      '';
    };

    modules.link.config."nvim/lua" = "symlink";

    programs.neovim = {
      # must be unwrapped or will fail
      package = unstable.neovim-unwrapped;
      enable = true;
      extraConfig = ''
        ${cfg.extraConfig}
      '';
      extraPackages = with pkgs; [
        fd
        ripgrep
        bat
      ];
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
  };
}
