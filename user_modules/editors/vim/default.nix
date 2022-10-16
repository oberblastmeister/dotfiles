{ config, nixosConfig, my, lib, pkgs, unstable, inputs, ... }:

let
  cfg = config.modules.editors.vim;
  inherit (lib) mkOption types;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  naiveNvimConfigDir = nixosConfig.dotfiles.naiveConfigDir + "/nvim";
  nvimConfigDir = nixosConfig.dotfiles.configDir + /nvim;
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
        " settings
        source ${nvimConfigDir + /settings.vim}
        
        " mappings
        source ${nvimMappingsDir + /command.vim}
        source ${nvimMappingsDir + /normal.vim}
        source ${nvimMappingsDir + /leader.vim}
        source ${nvimMappingsDir + /visual.vim}
        source ${nvimMappingsDir + /insert.vim}
        
        source ${naiveNvimConfigDir + "/user_init.lua"}
      '';
    };

    programs.neovim = {
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
