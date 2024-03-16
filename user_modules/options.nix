{ config, ... }:

{
  xdg.enable = true;

  # has to be in the home-manager section for some reason
  # nixpkgs.config = {
  #   allowUnfree = true;
  #   permittedInsecurePackages = [
  #     "electron-25.9.0"
  #     "nix-2.15.3"
  #   ];
  # };

  home.sessionPath = [ "$HOME/.local/bin" ];

  fonts.fontconfig.enable = true;
}
