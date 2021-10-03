{ config, config', my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.terminals.gnome-terminal;
in
{
  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    profile = {
      # profile id
      "f6042935-7b7a-4993-b312-d3fb2f4853ef" = {
        default = true;
        visibleName = "Gruvbox Dark";
        showScrollbar = false;
        audibleBell = false;
        colors = {
          foregroundColor = "#ebebdbdbb2b2";
          backgroundColor = "#282828282828";
          boldColor = "#ebebdbdbb2b2";
          cursor = {
            foreground = "#282828282828";
            background = "#ebebdbdbb2b2";
          };
          palette = [
            "#282828282828"
            "#cccc24241d1d"
            "#989897971a1a"
            "#d7d799992121"
            "#454585858888"
            "#b1b162628686"
            "#68689d9d6a6a"
            "#a8a899998484"
            "#929283837474"
            "#fbfb49493434"
            "#b8b8bbbb2626"
            "#fafabdbd2f2f"
            "#8383a5a59898"
            "#d3d386869b9b"
            "#8e8ec0c07c7c"
            "#ebebdbdbb2b2"
          ];
        };
      };
    };
  };
}
