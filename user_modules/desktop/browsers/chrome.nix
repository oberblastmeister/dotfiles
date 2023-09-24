{ options, config, lib, my, old, pkgs, unstable, very-unstable, ... }:

let
  cfg = config.modules.desktop.browsers.chrome;
  commandLineArgs = lib.strings.concatStringsSep " " [
    "--ignore-gpu-blocklist"
    "--ignore-gpu-blacklist"
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    "--disable-gpu-driver-bug-workarounds"
    "--enable-wayland-ime"
  ];
in
{
  options.modules.desktop.browsers.chrome = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.brave
      (unstable.chromium.override {
        inherit commandLineArgs;
      })
      (pkgs.google-chrome.override {
        inherit commandLineArgs;
      })
      (unstable.google-chrome-beta.override {
        inherit commandLineArgs;
      })
      (unstable.google-chrome-dev.override {
        inherit commandLineArgs;
      })
      # also needed for cargo doc --open to work
      (pkgs.writeShellScriptBin "chrome" ''
        google-chrome-unstable "$@" || google-chrome-beta "$@" || google-chrome-stable "$@"
      '')
    ];
  };
}
