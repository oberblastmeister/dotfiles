{ config, my, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.desktop.terminals.alacritty;
in

{
  options.modules.desktop.terminals.alacritty = {
    enable = my.options.mkEnable;
  };

  config = lib.mkIf cfg.enable {
    /* programs.alacritty = { */
    /*   enable = true; */
    /*   settings = { */
    /*     font = { */
    /*       normal = { */
    /*         family = "FiraCode Nerd Font 10"; */
    /*         style = "Regular"; */
    /*       }; */
    /*       bold = { */
    /*         family = "FiraCode Nerd Font 10"; */
    /*         style = "Bold"; */
    /*       }; */
    /*       italic = { */
    /*         family = "FiraCode Nerd Font 10"; */
    /*         style = "Regular"; */
    /*       }; */
    /*     }; */
    /*   }; */
    /* }; */
  };
}
