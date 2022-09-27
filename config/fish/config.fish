set -x LS_COLORS (vivid generate gruvbox-dark)

set fish_greeting # disable greeting

function ranger-cd
    set dir (mktemp -t ranger_cd.XXX)
    ranger --choosedir=$dir
    cd (cat $dir) $argv
    rm $dir
    commandline -f repaint
end

function lf-cd-repaint
    lfcd
    commandline -f repaint
end

function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert

    bind -M insert \co lf-cd-repaint
end

alias np="nix profile"
alias ls="exa --icons"
alias tree="exa --tree --icons"

alias hb="hadrian/build -j"
alias hbq="hb --flavour=Quick"
alias hbqs="hbq --skip='//*.mk' --skip='stage1:lib:rts'"
alias hbqf="hbqs --freeze1"

alias t=trash
alias ghb="gh browse"
