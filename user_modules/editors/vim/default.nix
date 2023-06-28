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
  };

  config = lib.mkIf cfg.enable {
    modules.link.config."nvim/lua" = "symlink";

    programs.neovim = {
      # must be unwrapped or will fail
      package = unstable.neovim-unwrapped;
      enable = true;
      extraPackages = with pkgs; [
        fd
        ripgrep
        bat
        xclip
        wl-clipboard
      ];
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
  };
}
