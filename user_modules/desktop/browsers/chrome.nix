{ options, config, lib, my, old, pkgs, ... }:

let
  cfg = config.modules.desktop.browsers.chrome;
in
{
  options.modules.desktop.browsers.chrome = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (google-chrome.override {
        # make sure this has no newlines
        commandLineArgs = "--ignore-gpu-blocklist --ignore-gpu-blacklist --enable-gpu-rasterization --enable-zero-copy --disable-gpu-driver-bug-workarounds";
      })
      chromium
      # also needed for cargo doc --open to work
      (pkgs.writeShellScriptBin "chrome" ''
        google-chrome-stable "$@"
      '')
    ];
  };
}
