# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "com/github/alainm23/planner" = {
      appearance = "Light";
      button-layout = "elementary";
      inbox-project = "int64 2227249482";
      pane-position = 317;
      quick-add-shortcut = "<Super>n";
      todoist-access-token = "05c9510a8239061531b1404b26ccaabed047eba3";
      todoist-account = true;
      todoist-last-sync = "2021-10-11T00:39:40+0000";
      todoist-sync-labels = true;
      todoist-sync-server = true;
      todoist-sync-token = "kJsWxbqgE2Fljz252yMI5R6FbAcr5JfwiQn3KNP0l3mqqWEcK7KNkLzxcbN3kwWE2r3qbOHcvl6lsC8BgrePc-CGCZylpPTsVwOcK6O_IycVv8c";
      todoist-user-avatar = "https://dcff1xvirvpfp.cloudfront.net/11da686d479049258c416c4b71972107_s640.jpg";
      todoist-user-email = "littlebubu.shu@gmail.com";
      todoist-user-id = 26520655;
      todoist-user-image-id = "11da686d479049258c416c4b71972107";
      todoist-user-is-premium = false;
      todoist-user-join-date = "2020-01-20T22:19:23Z";
      use-system-decoration = true;
      user-name = "littlebubu.shu";
      version = "2.7";
      window-maximized = false;
      window-position = mkTuple [ 26 23 ];
      window-size = mkTuple [ 1196 831 ];
    };

    "org/gnome/control-center" = {
      last-panel = "bluetooth";
    };

    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file:///nix/store/bri06vvgyaymz92s9w84qbdmkshpj3x2-gnome-backgrounds-40.1/share/backgrounds/gnome/Lava.jpg";
      primary-color = "#ffffff";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "ctrl:nocaps" ];
    };

    "org/gnome/desktop/interface" = {
      cursor-theme = "Bibata_Ice";
      document-font-name = "Noto Sans 11";
      font-name = "Noto Sans 11";
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Orchis";
      icon-theme = "ePapirus";
      monospace-font-name = "FiraCode Nerd Font 10";
      titlebar-font = "Noto Sans Bold 11";
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "firefox" "gnome-control-center" "discord" "gnome-power-panel" "com-github-alainm23-planner" ];
    };

    "org/gnome/desktop/notifications/application/com-github-alainm23-planner" = {
      application-id = "com.github.alainm23.planner.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-control-center" = {
      application-id = "gnome-control-center.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = "uint32 18";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      picture-options = "zoom";
      picture-uri = "file:///nix/store/bri06vvgyaymz92s9w84qbdmkshpj3x2-gnome-backgrounds-40.1/share/backgrounds/gnome/Lava.jpg";
      primary-color = "#ffffff";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      maximize = [ "<Alt><Super>k" ];
      minimize = [ "<Super>n" ];
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
      unmaximize = [ "<Alt><Super>j" ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
      network-monitor-gio-name = "";
    };

    "org/gnome/gnome-system-monitor" = {
      maximized = false;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-state = mkTuple [ 1457 820 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Alt><Super>h" ];
      toggle-tiled-right = [ "<Alt><Super>l" ];
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
      maximized = false;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = "uint32 2194";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      control-center = [ "<Super>s" ];
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      www = [ "<Super>b" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>n";
      command = "com.github.alainm23.planner.quick-add";
      name = "com.github.alainm23.planner.quick-add";
    };

    "org/gnome/shell" = {
      app-picker-layout = "[{'org.gnome.Contacts.desktop': <{'position': <0>}>, 'org.gnome.Weather.desktop': <{'position': <1>}>, 'org.gnome.clocks.desktop': <{'position': <2>}>, 'org.gnome.Maps.desktop': <{'position': <3>}>, 'org.gnome.Totem.desktop': <{'position': <4>}>, 'org.gnome.Calculator.desktop': <{'position': <5>}>, 'org.gnome.gedit.desktop': <{'position': <6>}>, 'simple-scan.desktop': <{'position': <7>}>, 'gnome-control-center.desktop': <{'position': <8>}>, 'gnome-system-monitor.desktop': <{'position': <9>}>, 'org.gnome.Terminal.desktop': <{'position': <10>}>, 'anki.desktop': <{'position': <11>}>, 'org.gnome.Characters.desktop': <{'position': <12>}>, 'org.gnome.FileRoller.desktop': <{'position': <13>}>, 'yelp.desktop': <{'position': <14>}>, 'org.gnome.Connections.desktop': <{'position': <15>}>, 'org.gnome.Screenshot.desktop': <{'position': <16>}>, 'ca.desrt.dconf-editor.desktop': <{'position': <17>}>, 'org.gnome.Cheese.desktop': <{'position': <18>}>, 'discord.desktop': <{'position': <19>}>, 'org.gnome.font-viewer.desktop': <{'position': <20>}>, 'org.gnome.baobab.desktop': <{'position': <21>}>, 'org.gnome.DiskUtility.desktop': <{'position': <22>}>, 'org.gnome.Evince.desktop': <{'position': <23>}>}, {'drracket.desktop': <{'position': <0>}>, 'element-desktop.desktop': <{'position': <1>}>, 'org.gnome.Extensions.desktop': <{'position': <2>}>, 'firefox.desktop': <{'position': <3>}>, 'firefox-private.desktop': <{'position': <4>}>, 'fish.desktop': <{'position': <5>}>, 'org.gnome.gThumb.desktop': <{'position': <6>}>, 'org.gnome.eog.desktop': <{'position': <7>}>, 'lf.desktop': <{'position': <8>}>, 'org.gnome.Logs.desktop': <{'position': <9>}>, 'Mailspring.desktop': <{'position': <10>}>, 'cups.desktop': <{'position': <11>}>, 'mpv.desktop': <{'position': <12>}>, 'nixos-manual.desktop': <{'position': <13>}>, 'org.gnome.seahorse.Application.desktop': <{'position': <14>}>, 'com.uploadedlobster.peek.desktop': <{'position': <15>}>, 'com.github.alainm23.planner.desktop': <{'position': <16>}>, 'slideshow.desktop': <{'position': <17>}>, 'org.gnome.Tour.desktop': <{'position': <18>}>, 'org.gnome.tweaks.desktop': <{'position': <19>}>, 'umpv.desktop': <{'position': <20>}>, 'nvim.desktop': <{'position': <21>}>, 'xterm.desktop': <{'position': <22>}>}]";
      disable-user-extensions = false;
      enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" "clipboard-indicator@tudmotu.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com" ];
      favorite-apps = [ "firefox.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Terminal.desktop" "gnome-system-monitor.desktop" ];
      welcome-dialog-last-shown-version = "40.4";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Orchis";
    };

    "org/gnome/shell/keybindings" = {
      toggle-message-tray = [];
      toggle-overview = [];
    };

    "org/gnome/shell/world-clocks" = {
      locations = "@av []";
    };

    "org/gnome/terminal/legacy" = {
      default-show-menubar = false;
      schema-version = 3;
      theme-variant = "default";
    };

    "org/gnome/terminal/legacy/profiles:" = {
      default = "f6042935-7b7a-4993-b312-d3fb2f4853ef";
      list = [ "f6042935-7b7a-4993-b312-d3fb2f4853ef" ];
    };

    "org/gnome/terminal/legacy/profiles:/:f6042935-7b7a-4993-b312-d3fb2f4853ef" = {
      audible-bell = false;
      background-color = "#282828282828";
      backspace-binding = "ascii-delete";
      bold-color = "#ebebdbdbb2b2";
      bold-color-same-as-fg = false;
      cursor-background-color = "#ebebdbdbb2b2";
      cursor-blink-mode = "system";
      cursor-colors-set = true;
      cursor-foreground-color = "#282828282828";
      cursor-shape = "block";
      delete-binding = "delete-sequence";
      foreground-color = "#ebebdbdbb2b2";
      highlight-colors-set = false;
      login-shell = false;
      palette = [ "#282828282828" "#cccc24241d1d" "#989897971a1a" "#d7d799992121" "#454585858888" "#b1b162628686" "#68689d9d6a6a" "#a8a899998484" "#929283837474" "#fbfb49493434" "#b8b8bbbb2626" "#fafabdbd2f2f" "#8383a5a59898" "#d3d386869b9b" "#8e8ec0c07c7c" "#ebebdbdbb2b2" ];
      scroll-on-output = true;
      scrollback-lines = 10000;
      scrollbar-policy = "never";
      use-custom-command = false;
      use-system-font = true;
      use-theme-colors = false;
      visible-name = "Gruvbox Dark";
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 163;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 665 87 ];
      window-size = mkTuple [ 1231 902 ];
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

    "org/virt-manager/virt-manager/vmlist-fields" = {
      disk-usage = false;
      network-traffic = false;
    };

  };
}
