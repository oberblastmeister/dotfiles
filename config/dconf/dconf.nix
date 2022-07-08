# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "apps/seahorse/listing" = {
      keyrings-selected = [ "secret-service:///org/freedesktop/secrets/collection/login" ];
    };

    "apps/seahorse/windows/key-manager" = {
      height = 476;
      width = 600;
    };

    "ca/desrt/dconf-editor" = {
      saved-pathbar-path = "";
      saved-view = "/com/github/libpinyin/ibus-libpinyin/";
      show-warning = false;
      window-height = 940;
      window-is-maximized = false;
      window-width = 2512;
    };

    "com/github/alainm23/planner" = {
      appearance = "Light";
      button-layout = "elementary";
      inbox-project = mkInt64 2227249482;
      pane-position = 249;
      quick-add-shortcut = "<Super>n";
      todoist-access-token = "05c9510a8239061531b1404b26ccaabed047eba3";
      todoist-account = true;
      todoist-last-sync = "2022-01-15T20:55:29-0500";
      todoist-sync-labels = true;
      todoist-sync-server = true;
      todoist-sync-token = "2VWGoJ3Zkr_96ISBPbYF0qXH1yz2z3hOz_tBZG1M4MBfMPrtSS5wwJHpWTnzj4aOKftbZifl2KaUmYKvZu5bSDCpDupNSGUnG-I1X1cgyMWLGDE";
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
      window-size = mkTuple [ 1296 1040 ];
    };

    "com/github/libpinyin/ibus-libpinyin/libpinyin" = {
      network-dictionary-end-timestamp = mkInt64 1600522231;
      network-dictionary-start-timestamp = mkInt64 1600522231;
    };

    "com/uploadedlobster/peek" = {
      persist-window-geometry = mkTuple [ 1336 269 ];
    };

    "desktop/ibus/general" = {
      preload-engines = [ "xkb:us::eng" "xkb:es::spa" "xkb:us::eng" ];
      version = "1.5.26";
    };

    "io/github/celluloid-player/celluloid" = {
      settings-migrated = true;
    };

    "io/github/celluloid-player/celluloid/window-state" = {
      height = 940;
      loop-playlist = false;
      maximized = false;
      playlist-width = 250;
      show-playlist = false;
      volume = 1.0;
      width = 1244;
    };

    "org/gnome/Connections" = {
      first-run = false;
    };

    "org/gnome/baobab/ui" = {
      window-size = mkTuple [ 764 988 ];
      window-state = 87168;
    };

    "org/gnome/boxes" = {
      first-run = false;
      view = "list-view";
      window-maximized = false;
      window-position = [ 56 50 ];
      window-size = [ 1244 988 ];
    };

    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "programming";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "";
      source-units = "degree";
      target-currency = "";
      target-units = "radian";
      window-position = mkTuple [ 207 122 ];
      word-size = 64;
    };

    "org/gnome/cheese" = {
      burst-delay = 1000;
      camera = "HD Webcam C615";
      photo-x-resolution = 960;
      photo-y-resolution = 720;
      video-x-resolution = 960;
      video-y-resolution = 720;
    };

    "org/gnome/clocks/state/window" = {
      panel-id = "world";
      size = mkTuple [ 2512 988 ];
      state = 87168;
    };

    "org/gnome/control-center" = {
      last-panel = "keyboard";
      window-state = mkTuple [ 1244 988 ];
    };

    "org/gnome/desktop/a11y/magnifier" = {
      mag-factor = 3.0;
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" ];
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.eog.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/brian/.local/share/backgrounds/2021-10-11-19-50-05-11-0-Color-Day.jpg";
      picture-uri-dark = "file:///home/brian/.local/share/backgrounds/2021-10-11-19-50-05-11-0-Color-Day.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "ibus" "rime" ]) (mkTuple [ "xkb" "es" ]) ];
      per-window = false;
      sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "es" ]) (mkTuple [ "ibus" "rime" ]) ];
      xkb-options = [ "ctrl:nocaps" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Ice";
      document-font-name = "Noto Sans 11";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "Noto Sans 11";
      gtk-theme = "Orchis";
      icon-theme = "ePapirus";
      monospace-font-name = "Cascadia Code 10";
      titlebar-font = "Noto Sans Bold 11";
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "firefox" "gnome-control-center" "discord" "gnome-power-panel" "com-github-alainm23-planner" "gnome-network-panel" "zoom" "anki" "gnome-printers-panel" "mailspring" "code" "org-gnome-nautilus" "obsidian" "virtualbox" "org-wezfurlong-wezterm" "gnome-system-monitor" "google-chrome" "org-gnome-boxes" "org-gnome-baobab" "org-gnome-polari" "heroic" "org-gnome-settings" ];
    };

    "org/gnome/desktop/notifications/application/anki" = {
      application-id = "anki.desktop";
    };

    "org/gnome/desktop/notifications/application/code" = {
      application-id = "code.desktop";
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

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-printers-panel" = {
      application-id = "gnome-printers-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-system-monitor" = {
      application-id = "gnome-system-monitor.desktop";
    };

    "org/gnome/desktop/notifications/application/google-chrome" = {
      application-id = "google-chrome.desktop";
    };

    "org/gnome/desktop/notifications/application/heroic" = {
      application-id = "heroic.desktop";
    };

    "org/gnome/desktop/notifications/application/mailspring" = {
      application-id = "Mailspring.desktop";
    };

    "org/gnome/desktop/notifications/application/obsidian" = {
      application-id = "obsidian.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
      application-id = "org.gnome.baobab.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-boxes" = {
      application-id = "org.gnome.Boxes.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-polari" = {
      application-id = "org.gnome.Polari.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/org-wezfurlong-wezterm" = {
      application-id = "org.wezfurlong.wezterm.desktop";
    };

    "org/gnome/desktop/notifications/application/virtualbox" = {
      application-id = "virtualbox.desktop";
    };

    "org/gnome/desktop/notifications/application/zoom" = {
      application-id = "Zoom.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = mkUint32 18;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      disable-microphone = false;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/brian/.local/share/backgrounds/2021-10-11-19-50-05-11-0-Color-Day.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
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
      switch-input-source = [ "<Primary><Super>Return" ];
      switch-input-source-backward = [ "<Primary><Shift><Super>Return" ];
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

    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "click";
      num-workspaces = 6;
      titlebar-font = "Noto Sans Bold 11";
    };

    "org/gnome/eog/view" = {
      background-color = "rgb(0,0,0)";
      use-background-color = true;
    };

    "org/gnome/epiphany/state" = {
      is-maximized = false;
      window-position = mkTuple [ (-1) (-1) ];
      window-size = mkTuple [ 1244 988 ];
    };

    "org/gnome/evince/default" = {
      window-ratio = mkTuple [ 4.104575163398692 1.2474747474747474 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
      network-monitor-gio-name = "";
    };

    "org/gnome/file-roller/dialogs/extract" = {
      recreate-folders = true;
      skip-newer = false;
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 480;
      window-width = 600;
    };

    "org/gnome/gedit/plugins" = {
      active-plugins = [ "docinfo" "modelines" "spell" "filebrowser" "sort" ];
    };

    "org/gnome/gedit/preferences/ui" = {
      show-tabs-mode = "auto";
    };

    "org/gnome/gedit/state/window" = {
      bottom-panel-size = 140;
      side-panel-active-page = "GeditWindowDocumentsPanel";
      side-panel-size = 200;
      size = mkTuple [ 620 956 ];
      state = 87168;
    };

    "org/gnome/gnome-screenshot" = {
      delay = 0;
      include-pointer = false;
      last-save-directory = "file:///home/brian/Pictures";
    };

    "org/gnome/gnome-system-monitor" = {
      current-tab = "processes";
      maximized = false;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-state = mkTuple [ 620 988 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      columns-order = [ 0 1 2 3 4 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 ];
      sort-col = 8;
      sort-order = 0;
    };

    "org/gnome/gthumb/browser" = {
      browser-sidebar-width = 285;
      fullscreen-sidebar = "hidden";
      fullscreen-thumbnails-visible = false;
      maximized = false;
      properties-visible = false;
      sidebar-sections = [ "GthFileProperties:expanded" "GthFileComment:expanded" "GthFileDetails:expanded" "GthImageHistogram:expanded" ];
      sidebar-visible = true;
      sort-inverse = false;
      sort-type = "file::mtime";
      startup-current-file = "file:///home/brian/projects/pvector/docs/diagram.png";
      startup-location = "file:///home/brian/projects/pvector/docs";
      statusbar-visible = true;
      thumbnail-list-visible = true;
      viewer-sidebar = "hidden";
      window-height = 988;
      window-width = 2560;
    };

    "org/gnome/gthumb/data-migration" = {
      catalogs-2-10 = true;
    };

    "org/gnome/gthumb/general" = {
      active-extensions = [ "23hq" "bookmarks" "burn_disc" "catalogs" "change_date" "comments" "contact_sheet" "convert_format" "desktop_background" "edit_metadata" "exiv2_tools" "file_manager" "find_duplicates" "flicker" "gstreamer_tools" "gstreamer_utils" "image_print" "image_rotation" "importer" "jpeg_utils" "list_tools" "oauth" "photo_importer" "raw_files" "red_eye_removal" "rename_series" "resize_images" "search" "selections" "slideshow" "terminal" "webalbums" ];
    };

    "org/gnome/libgnomekbd/preview" = {
      height = 809;
      width = 1944;
      x = 320;
      y = 135;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = false;
      experimental-features = [ "x11-randr-fractional-scaling" ];
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
      search-view = "list-view";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 613 988 ];
      maximized = false;
    };

    "org/gnome/polari" = {
      saved-channel-list = "@aa{sv} []";
      window-maximized = false;
      window-size = [ 610 988 ];
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 18.0;
      night-light-temperature = mkUint32 1700;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      control-center = [ "<Super>s" ];
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" ];
      screensaver = [];
      www = [ "<Super>b" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>n";
      command = "com.github.alainm23.planner.quick-add";
      name = "com.github.alainm23.planner.quick-add";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>t";
      command = "alacritty";
      name = "Launch terminal";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "suspend";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      app-picker-layout = "[{'org.gnome.Contacts.desktop': <{'position': <0>}>, 'org.gnome.Weather.desktop': <{'position': <1>}>, 'org.gnome.clocks.desktop': <{'position': <2>}>, 'org.gnome.Maps.desktop': <{'position': <3>}>, 'org.gnome.Totem.desktop': <{'position': <4>}>, 'org.gnome.Calculator.desktop': <{'position': <5>}>, 'simple-scan.desktop': <{'position': <6>}>, 'anki.desktop': <{'position': <7>}>, 'yelp.desktop': <{'position': <8>}>, 'ca.desrt.dconf-editor.desktop': <{'position': <9>}>, 'org.gnome.Cheese.desktop': <{'position': <10>}>, 'discord.desktop': <{'position': <11>}>}, {'drracket.desktop': <{'position': <0>}>, 'element-desktop.desktop': <{'position': <1>}>, 'org.gnome.Extensions.desktop': <{'position': <2>}>, 'fish.desktop': <{'position': <3>}>, 'org.gnome.gThumb.desktop': <{'position': <4>}>, 'lf.desktop': <{'position': <5>}>, 'Mailspring.desktop': <{'position': <6>}>, 'cups.desktop': <{'position': <7>}>, 'mpv.desktop': <{'position': <8>}>, 'nixos-manual.desktop': <{'position': <9>}>, 'com.github.alainm23.planner.desktop': <{'position': <10>}>, 'slideshow.desktop': <{'position': <11>}>, 'org.gnome.Tour.desktop': <{'position': <12>}>, 'org.gnome.Boxes.desktop': <{'position': <13>}>, 'io.github.celluloid_player.Celluloid.desktop': <{'position': <14>}>, 'umpv.desktop': <{'position': <15>}>, 'nl.hjdskes.gcolor3.desktop': <{'position': <16>}>, 'nvim.desktop': <{'position': <17>}>, 'coqide.desktop': <{'position': <18>}>, 'xterm.desktop': <{'position': <19>}>, 'emacs.desktop': <{'position': <20>}>, 'emacsclient.desktop': <{'position': <21>}>, 'org.gnome.Calendar.desktop': <{'position': <22>}>, 'firefox.desktop': <{'position': <23>}>}, {'org.gnome.Geary.desktop': <{'position': <0>}>, 'org.gnome.Music.desktop': <{'position': <1>}>, 'org.gnome.Photos.desktop': <{'position': <2>}>, 'virt-manager.desktop': <{'position': <3>}>, 'code.desktop': <{'position': <4>}>, 'org.gnome.Epiphany.desktop': <{'position': <5>}>, 'org.flameshot.Flameshot.desktop': <{'position': <6>}>, 'Zoom.desktop': <{'position': <7>}>, 'gpick.desktop': <{'position': <8>}>, 'heroic.desktop': <{'position': <9>}>, 'kitty.desktop': <{'position': <10>}>, 'net.lutris.Lutris.desktop': <{'position': <11>}>, 'minecraft-launcher.desktop': <{'position': <12>}>, 'obsidian.desktop': <{'position': <13>}>, 'virtualbox.desktop': <{'position': <14>}>, 'com.uploadedlobster.peek.desktop': <{'position': <15>}>, 'qalculate-gtk.desktop': <{'position': <16>}>, 'ranger.desktop': <{'position': <17>}>, 'org.gnome.Settings.desktop': <{'position': <18>}>, 'steam.desktop': <{'position': <19>}>, 'tectonic.desktop': <{'position': <20>}>, 'org.gnome.TextEditor.desktop': <{'position': <21>}>, 'com.system76.Popsicle.desktop': <{'position': <22>}>, 'Utilities': <{'position': <23>}>}, {'org.pwmt.zathura.desktop': <{'position': <0>}>, 'zotero-6.0.4.desktop': <{'position': <1>}>}]";
      disable-user-extensions = false;
      disabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" "clipboard-indicator@tudmotu.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com" "pop-shell@system76.com" ];
      favorite-apps = [ "google-chrome.desktop" "org.gnome.Nautilus.desktop" "Alacritty.desktop" "gnome-system-monitor.desktop" ];
      welcome-dialog-last-shown-version = "40.4";
    };

    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = false;
      gap-inner = mkUint32 6;
      gap-outer = mkUint32 6;
      show-title = true;
      smart-gaps = false;
      snap-to-grid = true;
      tile-by-default = true;
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

    "org/gnome/simple-scan" = {
      document-type = "photo";
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

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 175;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-size = mkTuple [ 862 374 ];
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.0 0.0 ]) ];
      selected-color = mkTuple [ true 0.0 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 196;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 664 87 ];
      window-size = mkTuple [ 1231 902 ];
    };

    "org/virt-manager/virt-manager" = {
      manager-window-height = 952;
      manager-window-width = 2512;
    };

    "org/virt-manager/virt-manager/confirm" = {
      delete-storage = true;
      removedev = true;
      unapplied-dev = true;
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

    "org/virt-manager/virt-manager/conns/qemu:system" = {
      window-size = mkTuple [ 800 600 ];
    };

    "org/virt-manager/virt-manager/details" = {
      show-toolbar = true;
    };

    "org/virt-manager/virt-manager/new-vm" = {
      graphics-type = "system";
    };

    "org/virt-manager/virt-manager/paths" = {
      media-default = "/home/brian/Downloads";
    };

    "org/virt-manager/virt-manager/urls" = {
      isos = [ "/home/brian/Downloads/Win11_English_x64v1.iso" "/home/brian/Downloads/nixos-gnome-21.05.3740.ce7a1190a0f-x86_64-linux.iso" ];
    };

    "org/virt-manager/virt-manager/vmlist-fields" = {
      disk-usage = false;
      network-traffic = false;
    };

    "org/virt-manager/virt-manager/vms/8740d8464bf54aa9b541113f6087e53e" = {
      autoconnect = 1;
      scaling = 1;
      vm-window-size = mkTuple [ 1024 812 ];
    };

    "org/virt-manager/virt-manager/vms/a65a1ca5e4a84c3298937eaba4ef0ddc" = {
      autoconnect = 1;
      scaling = 0;
      vm-window-size = mkTuple [ 1244 952 ];
    };

    "org/virt-manager/virt-manager/vms/b894de2283ff42e5a89eedf919584766" = {
      autoconnect = 1;
      scaling = 1;
      vm-window-size = mkTuple [ 1024 841 ];
    };

    "system/proxy" = {
      mode = "none";
    };

  };
}
