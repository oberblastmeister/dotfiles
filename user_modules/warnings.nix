{ config, ... }:

{
  config = {
    warnings =
      if !config.programs.zsh.enable && !config.programs.fish.enable && !config.programs.bash.enable
      then [ "You must enable one of bash, zsh, or fish in home-manager because sessionVariables rely on home-manager managing the shell" ]
      else [];
  };
}
