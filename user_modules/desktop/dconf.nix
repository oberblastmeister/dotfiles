{ config, nixosConfig, options, unstable, pkgs, lib, my, ... }:

let
  nixosCfg = nixosConfig.modules.desktop.gnome;
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  config = lib.mkIf nixosCfg.enable {
    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        maximize = [ "<Alt><Super>k" ];
        minimize = [ "<Super>n" ];
        unmaximize = [ "<Alt><Super>j" ];
        move-to-monitor-down = [ "<Shift><Super>braceleft" ];
        move-to-monitor-left = [ "<Shift><Super>braceright" ];
        move-to-workspace-1 = [ "<Shift><Super>exclam" ];
        move-to-workspace-2 = [ "<Shift><Super>at" ];
        move-to-workspace-3 = [ "<Shift><Super>numbersign" ];
        move-to-workspace-4 = [ "<Shift><Super>dollar" ];
        move-to-workspace-left = [ "<Alt><Super>bracketleft" ];
        move-to-workspace-right = [ "<Alt><Super>bracketright" ];
        show-desktop = [ "<Primary><Super>n" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-left = [ "<Super>bracketleft" ];
        switch-to-workspace-right = [ "<Super>bracketright" ];
        toggle-fullscreen = [ "<Super>f" ];
        toggle-maximized = [ "<Super>m" ];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ "<Alt><Super>h" ];
        toggle-tiled-right = [ "<Alt><Super>l" ];
      };
      "org/gnome/shell/keybindings" = {
        # conflicting keybindings
        toggle-message-tray = [ ];
        toggle-overview = [ ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        control-center = [ "<Super>s" ];
        www = [ "<Super>b" ];
      };
      "org/gnome/desktop/interface" = {
        cursor-theme = "Bibata_Ice";
        gtk-theme = "Orchis";
        icon-theme = "ePapirus";
        font-name = "Noto Sans 11";
        document-font-name = "Noto Sans 11";
        monospace-font-name = "FiraCode Nerd Font 10";
        titlebar-font = "Noto Sans Bold 11";
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "Orchis";
      };
      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "ctrl:nocaps" ];
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        disable-while-typing = false;
        two-finger-scrolling-enabled = true;
      };
      "org/gnome/desktop/peripherals/keyboard" = {
        # broken for some reason
        repeat-interval = "uint32 17";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "clipboard-indicator@tudmotu.com"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };
    };
  };
}
