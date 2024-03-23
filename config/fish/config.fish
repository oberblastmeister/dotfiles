set -x LS_COLORS (vivid generate gruvbox-dark)

set fish_greeting # disable greeting

function ranger-cd
    set dir (mktemp -t ranger_cd.XXX)
    ranger --choosedir=$dir
    cd (cat $dir) $argv
    rm $dir
    commandline -f repaint
end

function yazi-cd
    set tmp (mktemp)
    # `command` is needed in case `lfcd` is aliased to `lf`
    command yazi --cwd-file=$tmp $argv
    if test -f "$tmp"
        set dir (cat $tmp)
        command rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end

function lf-cd-repaint
    lfcd
    commandline -f repaint
end

function yazi-cd-repaint
    yazi-cd
    commandline -f repaint
end

function testing
    echo "bruhbruhbruh"
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
    # bind -M insert \co yazi-cd-repaint
    # bind -M insert \cw testing
end

alias st='sublime4'

# alias np="nix profile"
alias ls="exa --icons"
alias tree="exa --tree --icons"

alias hb="hadrian/build -j"
alias hbf="hb --freeze1"
alias hbq="hb --flavour=Quick"
alias hbqs="hbq --skip='//*.mk' --skip='stage1:lib:rts'"
alias hbqf="hbq --freeze1"
alias hadrian_load_hls='hadrian/build --build-root=.hie-bios --flavour=ghc-in-ghci --docs=none -j tool:ghc/Main.hs'

alias rm='echo "Not running rm. This command is dangerous!"; false'
alias t=trash
alias ghb="gh browse"
# alias code="code --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations"

alias dbs='distrobox-host-exec $SHELL'
alias dbh='distrobox-host-exec'
alias db='distrobox'
alias dbe='db enter'
alias dba='distrobox-export -a'
function dbb
    distrobox-export --bin (realpath (command -v "$argv[1]")) --export-path ~/.local/bin
end
alias zcc='zig cc'
alias venv='source .venv/bin/activate.fish'
alias venvd='deactivate'
alias cp_template='wl-copy < ~/projects/my/cp_template/ocaml/template.ml'

# add these because we need to prepend to path
fish_add_path ~/.cabal/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/bin/zig-linux-x86_64-0.12.0-dev.163+6780a6bbf
fish_add_path ~/.rye/shims
fish_add_path ~/.pack/bin
