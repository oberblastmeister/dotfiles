{ options, config, unstable, pkgs, lib, my, ... }:

let
  cfg = config.modules.dev.rust;
in
{
  options.modules.dev.rust = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rustup
      cargo-watch
      cargo-edit
      cargo-expand
      cargo-outdated
    ];

    home.sessionPath = [ "$HOME/.cargo/bin" ];
  };
}
